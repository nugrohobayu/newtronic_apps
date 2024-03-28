import 'dart:io';

import 'package:external_path/external_path.dart';

class DownloadsPath {
  static Future<String> downloadsDirectory() async {
    final downDir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final appDocDir = Directory('$downDir/NEWTRONIC');

    if (await appDocDir.exists()) {
      return appDocDir.path;
    } else {
      final appNewDir = await appDocDir.create(recursive: true);
      return appNewDir.path;
    }
  }
}
