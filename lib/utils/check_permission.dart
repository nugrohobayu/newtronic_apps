import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<bool> storage() async {
    final android = await DeviceInfoPlugin().androidInfo;
    final permissionStorage = await Permission.storage.status;
    final permissionPhotos = await Permission.photos.status;

    if (android.version.sdkInt! < 33) {
      if (permissionStorage.isDenied) {
        final permission = await Permission.storage.request();

        if (permission.isDenied || permission.isPermanentlyDenied) {
          await openAppSettings();
        }
        return false;
      } else if (permissionStorage.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
      return permissionStorage.isGranted;
    } else {
      if (permissionPhotos.isDenied) {
        final permission = await Permission.photos.request();

        if (permission.isDenied || permission.isPermanentlyDenied) {
          await openAppSettings();
        }
        return false;
      } else if (permissionPhotos.isPermanentlyDenied) {
        await openAppSettings();
        return false;
      }
      return permissionPhotos.isGranted;
    }
  }
}
