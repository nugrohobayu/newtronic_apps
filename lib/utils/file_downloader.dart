import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newtronic_apps/utils/check_permission.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'downloads_path.dart';

class FileDownloader {
  final dio = Dio();
  Future<bool> downloadFromUrl(String url, String fileName) async {
    final directory = Platform.isAndroid
        ? (await DownloadsPath.downloadsDirectory())
        : (await getApplicationDocumentsDirectory()).path;
    final isGranted =
        Platform.isAndroid ? await CheckPermission.storage() : true;

    if (isGranted) {
      try {
        await dio.download(url, '$directory/$fileName');
      } catch (e) {
        debugPrint(e.toString());
        return false;
      }
    }
    return true;
  }
}
