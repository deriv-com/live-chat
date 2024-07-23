import 'package:live_chat/src/live_chat_platform_interface.dart';

class LiveChat {
  static final LiveChat _singleton = LiveChat._internal();

  factory LiveChat() {
    return _singleton;
  }

  LiveChat._internal();

  Future<void> openChatView({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) async {
    return LiveChatPlatform.instance.openChatView(
      licenseId: licenseId,
      username: username,
      email: email,
      groupId: groupId,
      customParameters: customParameters,
    );
  }

  Future<void> closeChatView() async {
    return LiveChatPlatform.instance.closeChatView();
  }

  Future<void> clearChatView() async {
    return LiveChatPlatform.instance.clearChatView();
  }

  Stream<dynamic>? get onEventReceived =>
      LiveChatPlatform.instance.getEventsStream();
}
