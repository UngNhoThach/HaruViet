import 'package:copy_with_extension/copy_with_extension.dart';

part 'file_info_message.g.dart';

@CopyWith()
class FileInfoMessage {
  FileInfoMessage({
    this.fileFormat,
    this.fileName,
    this.filePath,
    this.fileStatus,
    this.fileSize,
    this.thumb,
  });

  final String? fileFormat;
  final String? fileName;
  final String? filePath;
  final String? fileStatus;
  final String? fileSize;
  final String? thumb;
}
