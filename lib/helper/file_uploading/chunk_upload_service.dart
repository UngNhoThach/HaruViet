import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haruviet/api/rest_client.dart';
import 'package:haruviet/data/reponsitory/setting/setting_repository.dart';
import 'package:haruviet/helper/file_extensisons.dart';
import 'package:haruviet/helper/file_uploading/chunked_uploader.dart';
import 'package:haruviet/helper/file_uploading/file_info_message.dart';

import 'package:uuid/uuid.dart';

class UploadFile extends ChangeNotifier {
  final _settingRepository = SettingRepository();

  late Dio dio;

  late ChunkedUploader uploader;

  bool isUploading = false;

  UploadFile() {
    uploader = ChunkedUploader(RestClient.dio);
  }

  List<UploadProcess> listUploadProcess = [];
  List<FileInfoMessage> listFileInfoMessage = [];

  String? fileName;
  String? filePath;

  Future<void> addFile(
    List<PlatformFile> files, {
    DomainUpload? domainUpload,
    int? folderId,
  }) async {
    for (int i = 0; i < files.length; i++) {
      listUploadProcess.add(UploadProcess(file: files[i], percent: 0));
    }
    if (!isUploading) {
      await runUploadListFile(
        domainUpload: domainUpload,
        folderId: folderId,
      );
    }
  }

  void initFile(List<FileInfoMessage> list) {
    listFileInfoMessage = list;
    listUploadProcess = list
        .map(
          (e) => UploadProcess(
            file: PlatformFile(
              name: '',
              size: 0,
            ),
            percent: 100,
            isError: false,
          ),
        )
        .toList();
    notifyListeners();
  }

  void removeFileAt(int index) {
    if (listUploadProcess.isNotEmpty) {
      listUploadProcess.removeAt(index);
      if (listFileInfoMessage.isNotEmpty) {
        listFileInfoMessage.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFileAtValue(FileInfoMessage files, String? domainApi) {
    if (listUploadProcess.isNotEmpty) {
      final index = domainApi == null
          ? listFileInfoMessage
              .indexWhere((value) => value.filePath == files.filePath)
          : files.fileFormat == 'image'
              ? listFileInfoMessage.indexWhere(
                  (value) => '$domainApi${value.filePath}' == files.filePath)
              : listFileInfoMessage.indexWhere(
                  (value) => '$domainApi${value.thumb}' == files.thumb);
      if (index != -1) {
        listUploadProcess.removeAt(index);
        if (listFileInfoMessage.isNotEmpty) {
          listFileInfoMessage.removeAt(index);
        }
        notifyListeners();
      }
    }
  }

  void clearAllFile() {
    if (listUploadProcess.isNotEmpty) {
      listUploadProcess.clear();
      listUploadProcess = [];
      if (listFileInfoMessage.isNotEmpty) {
        listFileInfoMessage.clear();
        listFileInfoMessage = [];
      }
      notifyListeners();
    }
  }

  Future<void> fileRunning() async {}

  Future<void> runUploadListFile({
    DomainUpload? domainUpload,
    int? folderId,
  }) async {
    for (int i = 0; i < listUploadProcess.length; i++) {
      if (listUploadProcess[i].percent < 1) {
        isUploading = true;
        await uploadFile(
          file: listUploadProcess[i].file,
          index: i,
          domainUpload: domainUpload,
          folderId: folderId,
        );
      }
    }
    isUploading = false;
  }

  Future<void> uploadFile({
    required PlatformFile file,
    required int index,
    DomainUpload? domainUpload,
    int? folderId,
  }) async {
    final uuid = const Uuid().v4();

    try {
      final fileFormat = getFileFormat(file.path!);
      final result = await uploader.uploadUsingFilePath(
        fileName: file.name,
        filePath: file.path!,
        path: '/apimobile/postChunk',
        maxChunkSize: 500000,
        fileKey: "bytes",
        fileCode: uuid,
        onUploadProgress: (progress) {
          if (progress <= 1) {
            listUploadProcess[index].percent = progress;
          } else {
            listUploadProcess[index].percent = 1;
          }

          notifyListeners();
        },
        type: fileFormat == 'image' ? 'image' : null,
        domainUpload: domainUpload,
        folderId: folderId,
      );
      fileName = file.name;
      filePath = result?.data;

      if (fileFormat == 'video') {
        // final thumb =
        //     await _settingRepository.renderThumbVideo(videoPath: result?.data);
        listFileInfoMessage.add(
          FileInfoMessage(
            fileFormat: fileFormat,
            fileName: file.name,
            filePath: result?.data,
            fileStatus: null,
            fileSize: '${File(file.path!).sizeOfImage().toStringAsFixed(2)}MB',
            thumb: '', //thumb,
          ),
        );
      } else {
        listFileInfoMessage.add(
          FileInfoMessage(
            fileFormat: fileFormat,
            fileName: file.name,
            filePath: result?.data,
            fileStatus: null,
            fileSize: '${File(file.path!).sizeOfImage().toStringAsFixed(2)}MB',
          ),
        );
      }

      notifyListeners();
    } catch (error) {
      listUploadProcess[index].isError = false;
      notifyListeners();
    }
  }
}

String? getFileFormat(String path) {
  String key = path.split('.').last.toLowerCase();
  if (['jpg', 'jpeg', 'png', 'gif'].contains(key)) {
    return 'image';
  }
  if (['flv', 'avi', 'mp4', 'mkv', '3gp'].contains(key)) {
    return 'video';
  }
  if (['doc', 'docx'].contains(key)) {
    return 'word';
  }
  if (['xls', 'xlsx'].contains(key)) {
    return 'excel';
  }
  if (['pdf'].contains(key)) {
    return 'pdf';
  }
  if (['ppt', 'pptx'].contains(key)) {
    return 'ppt';
  }
  if (['txt'].contains(key)) {
    return 'text';
  }
  if (['zip', 'rar'].contains(key)) {
    return 'zip';
  }
  if (['exe'].contains(key)) {
    return null;
  }
  return 'file';
}

class UploadProcess {
  final PlatformFile file;
  double percent;
  bool isError;

  UploadProcess({
    required this.file,
    required this.percent,
    this.isError = false,
  });
}
