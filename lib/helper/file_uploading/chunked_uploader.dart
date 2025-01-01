library chunked_uploader;

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:haruviet/data/local/user_preferences.dart';
import 'package:universal_io/io.dart';

enum DomainUpload {
  initial,
  document,
}

/// Uploads large files by chunking them into smaller parts
class ChunkedUploader {
  final Dio _dio;

  const ChunkedUploader(this._dio);

  /// Uploads the file using it's data stream
  /// Suitable for Web platform since the file path isn't available
  Future<Response?> upload({
    required Stream<List<int>> fileDataStream,
    required String fileName,
    required int fileSize,
    required String path,
    required String fileCode,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    int? maxChunkSize,
    Function(double)? onUploadProgress,
    ChunkHeadersCallback? headersCallback,
    String method = 'POST',
    String fileKey = 'file',
  }) =>
      _Uploader(
        _dio,
        fileDataStream: fileDataStream,
        fileName: fileName,
        fileSize: fileSize,
        fileCode: fileCode,
        path: path,
        fileKey: fileKey,
        method: method,
        data: data,
        cancelToken: cancelToken,
        maxChunkSize: maxChunkSize,
        onUploadProgress: onUploadProgress,
        headersCallback: headersCallback,
      ).upload();

  /// Uploads the file using it's path
  Future<Response?> uploadUsingFilePath({
    required String filePath,
    required String fileName,
    required String path,
    required String fileCode,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    int? maxChunkSize,
    Function(double)? onUploadProgress,
    ChunkHeadersCallback? headersCallback,
    String method = 'POST',
    String fileKey = 'file',
    String? type,
    DomainUpload? domainUpload,
    int? folderId,
  }) =>
      _Uploader.fromFilePath(
        _dio,
        filePath: filePath,
        fileName: fileName,
        fileCode: fileCode,
        path: path,
        fileKey: fileKey,
        method: method,
        data: data,
        cancelToken: cancelToken,
        maxChunkSize: maxChunkSize,
        onUploadProgress: onUploadProgress,
        headersCallback: headersCallback,
      ).upload(
        type: type,
        domainUpload: domainUpload,
        folderId: folderId,
      );
}

class _Uploader {
  final Dio dio;
  late final int fileSize;
  late final ChunkedStreamReader<int> streamReader;
  final String fileName, path, fileKey;
  final String fileCode;
  final String? method;
  final Map<String, dynamic>? data;
  final CancelToken? cancelToken;
  final Function(double)? onUploadProgress;
  late int _maxChunkSize;
  final ChunkHeadersCallback _headersCallback;
  late final List<int> fileBytes;

  _Uploader(
    this.dio, {
    required Stream<List<int>> fileDataStream,
    required this.fileName,
    required this.fileSize,
    required this.path,
    required this.fileKey,
    required this.fileCode,
    this.method,
    this.data,
    this.cancelToken,
    this.onUploadProgress,
    ChunkHeadersCallback? headersCallback,
    int? maxChunkSize,
  })  : streamReader = ChunkedStreamReader(fileDataStream),
        _maxChunkSize = min(fileSize, maxChunkSize ?? fileSize),
        _headersCallback = headersCallback ?? _defaultHeadersCallback;

  _Uploader.fromFilePath(
    this.dio, {
    required String filePath,
    required this.fileName,
    required this.path,
    required this.fileKey,
    required this.fileCode,
    this.method,
    this.data,
    this.cancelToken,
    this.onUploadProgress,
    ChunkHeadersCallback? headersCallback,
    int? maxChunkSize,
  }) : _headersCallback = headersCallback ?? _defaultHeadersCallback {
    final file = File(filePath);
    streamReader = ChunkedStreamReader(file.openRead());
    fileSize = file.lengthSync();
    fileBytes = file.readAsBytesSync();
    _maxChunkSize = min(fileSize, maxChunkSize ?? fileSize);
  }

  Future<Response?> upload({
    String? type,
    DomainUpload? domainUpload,
    int? folderId,
  }) async {
    try {
      Response? finalResponse;
      String? employeeId;
      String? fullName;

      if (domainUpload != null) {
        final data = await Preference.getUserInfo();
        // employeeId = data?.employeeId;
        // fullName = data?.fullName;
        if (data != null) {
          if (domainUpload == DomainUpload.document) {
            // dio.options.baseUrl = data.domainDocument ?? '';
          }
        }
      }

      for (int i = 0; i < chunksCount; i++) {
        final start = _getChunkStart(i);
        final end = _getChunkEnd(i);

        final chunkByte = fileBytes.getRange(start, end).toList();
        final formData = FormData.fromMap({
          fileKey: base64Encode(chunkByte),
          "index": i,
          "fileCode": fileCode,
        });
        await dio.request(
          path,
          data: formData,
          cancelToken: cancelToken,
          options: Options(
            method: method,
            headers: _headersCallback(start, end, fileSize),
          ),
          onSendProgress: (current, total) =>
              _updateProgress(i, current, total),
        );
      }
      var body = {
        "fileCode": fileCode,
        "count": chunksCount,
        "fileName": fileName,
        "type": type,
      };

      if (domainUpload != null) {
        if (domainUpload == DomainUpload.document) {
          body = {
            "fileCode": fileCode,
            "count": chunksCount,
            "fileName": fileName,
            "type": type,
            "folderId": folderId,
            "employeeId": employeeId,
            "employeeName": fullName,
          };
          //   finalResponse = await dio.post(DocumentApi.mergeFileDoc, data: body);
        }
      } else {
        //     finalResponse = await dio.get(UploadApi.mergeFile, data: body);
      }

      return finalResponse;
    } catch (_) {
      rethrow;
    } finally {
      streamReader.cancel();
    }
  }

  // Updating total upload progress
  void _updateProgress(int chunkIndex, int chunkCurrent, int chunkTotal) {
    int totalUploadedSize = (chunkIndex * _maxChunkSize) + chunkCurrent;
    double totalUploadProgress = totalUploadedSize / fileSize;
    onUploadProgress?.call(totalUploadProgress);
  }

  // Returning start byte offset of current chunk
  int _getChunkStart(int chunkIndex) => chunkIndex * _maxChunkSize;

  // Returning end byte offset of current chunk
  int _getChunkEnd(int chunkIndex) =>
      min((chunkIndex + 1) * _maxChunkSize, fileSize);

  // Returning chunks count based on file size and maximum chunk size
  int get chunksCount => (fileSize / _maxChunkSize).ceil();
}

typedef ChunkHeadersCallback = Map<String, dynamic> Function(
    int start, int end, int fileSize);

// ignore: prefer_function_declarations_over_variables
final ChunkHeadersCallback _defaultHeadersCallback =
    (int start, int end, int fileSize) =>
        {'Content-Range': 'bytes $start-${end - 1}/$fileSize'};
