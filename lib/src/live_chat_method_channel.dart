import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:live_chat/src/live_chat_platform_interface.dart';

/// An implementation of [LiveChatPlatform] that uses method channels.
class MethodChannelLiveChat extends LiveChatPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('live_chat/channel');

  static const EventChannel eventsChannel = EventChannel('live_chat/events');

  @override
  Future<void> openChatView({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) {
    return methodChannel.invokeMethod<dynamic>(
      'open_live_chat_view',
      <String, dynamic>{
        'licenseId': licenseId,
        'visitorName': username,
        'visitorEmail': email,
        'groupId': groupId,
        'customParams': customParameters,
      },
    );
  }

  @override
  Future<void> closeChatView() async {
    return methodChannel.invokeMethod<dynamic>('close_live_chat_view');
  }

  @override
  Future<void> clearChatView() async {
    return methodChannel.invokeMethod<dynamic>('clear_live_chat_view');
  }

  @override
  Stream? getEventsStream() {
    return eventsChannel.receiveBroadcastStream();
  }
}
