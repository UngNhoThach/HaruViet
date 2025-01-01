import 'dart:io';
import 'dart:math';

extension FileExtension on File {
  double sizeOfImage([
    int decimal = 1,
  ]) {
    final file = File(path);
    if (file.existsSync()) {
      final bytes = file.lengthSync();
      if (bytes <= 0) {
        return 0;
      }
      final size = (bytes / pow(1024, 2));

      return size;
    }
    return 0;
  }
}
