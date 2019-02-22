import 'dart:async';

import 'package:flutter/services.dart';

class FlutterKeyboardPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_keyboard_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
