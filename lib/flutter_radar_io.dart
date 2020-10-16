import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter_radar_io/models.dart';

typedef void RadarCallBack({
  @required String status,
  Map<dynamic, dynamic> location,
  List<Map<dynamic, dynamic>> events,
  Map<dynamic, dynamic> user,
});

class FlutterRadarIo {
  static const MethodChannel _channel = const MethodChannel('flutter_radar_io');
  static const EventChannel _eventChannel = const EventChannel("radarStream");

  static Stream<dynamic> _radarStream;
  static RadarCallBack _callBack;

  static Future<bool> initialize({
    @required String publishableKey,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'publishableKey': publishableKey
    };
    final bool result = await _channel.invokeMethod("initialize", params);
    _channel.setMethodCallHandler(_methodCallHandler);
    return result;
  }

  static Future<bool> setLogLevel({
    @required String level,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{'level': level};
    final bool result = await _channel.invokeMethod("set-log-level", params);
    return result;
  }

  static Future<bool> setUserId({
    @required String uid,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{'uid': uid};
    final bool result = await _channel.invokeMethod("set-user-id", params);
    return result;
  }

  static Future<String> getUserId() async {
    final String result = await _channel.invokeMethod("get-user-id");
    return result;
  }

  static Future<bool> setMetadata({
    @required Map<String, dynamic> metadata,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{'meta': metadata};
    final bool result = await _channel.invokeMethod("set-metadata", params);
    return result;
  }

  static Future<Map<String, dynamic>> getMetaData() async {
    final String result = await _channel.invokeMethod("get-metadata");
    Map<String, dynamic> map = jsonDecode(result);
    return map;
  }

  static Future<bool> setDescription({
    @required String description,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'description': description
    };
    final bool result = await _channel.invokeMethod("set-description", params);
    return result;
  }

  static Future<String> getDescription() async {
    final String result = await _channel.invokeMethod("get-description");
    return result;
  }

  static Future<Map<String, dynamic>> trackOnce() async {
    final String result = await _channel.invokeMethod("track-once");
    final Map<String, dynamic> map = jsonDecode(result);
    return map;
  }

  static Future<bool> isTracking() async {
    final bool result = await _channel.invokeMethod("is-tracking");
    return result;
  }

  static Future<bool> stopTracking() async {
    final bool result = await _channel.invokeMethod("stop-tracking");
    return result;
  }

  static Future<bool> startTracking({
    @required String mode,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{'mode': mode};
    final bool result = await _channel.invokeMethod("start-tracking", params);
    return result;
  }

  static Stream<Location> get radarStream {
    _radarStream ??= _eventChannel.receiveBroadcastStream();
    return _radarStream.map((event) => Location.fromJson(jsonDecode(event)));
  }

  static Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'callback':
        _callBack(
          status: call.arguments['status'],
          location: call.arguments['location'],
          events: call.arguments['events'],
          user: call.arguments['user'],
        );
        break;
      default:
        print('This normally shouldn\'t happen.');
    }
  }
}
