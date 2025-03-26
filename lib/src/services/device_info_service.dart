import 'package:flutter/services.dart';

class DeviceInfoService {
  static const platform = MethodChannel('device_info');

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final result = await platform.invokeMethod('getDeviceInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print("Failed to get device info: '${e.message}'.");
      return {};
    }
  }
}