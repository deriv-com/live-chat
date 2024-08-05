import 'package:flutter/services.dart';
import 'package:live_chat_plus/src/live_chat_platform_interface.dart';
import 'package:live_chat_plus/src/utils/constants.dart';

/// An implementation of [LiveChatPlatform] that uses method channels.
class MethodChannelLiveChat extends LiveChatPlatform {
  static const MethodChannel _methodChannel = MethodChannel(
    methodChannelName,
  );
  static const EventChannel _eventsChannel = EventChannel(
    eventChannelName,
  );

  @override
  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) =>
      _methodChannel.invokeMethod<dynamic>(
        openChatWindowKey,
        <String, dynamic>{
          licenseIdKey: licenseId,
          visitorNameKey: username,
          visitorEmailKey: email,
          groupIdKey: groupId,
          customParamsKey: customParameters,
        },
      );

  @override
  Future<void> closeChatWindow() async =>
      _methodChannel.invokeMethod<dynamic>(closeChatWindowKey);

  @override
  Future<void> clearChatSession() async =>
      _methodChannel.invokeMethod<dynamic>(clearChatSessionKey);

  @override
  Stream<dynamic>? getLiveChatEventsStream() =>
      _eventsChannel.receiveBroadcastStream();
}
