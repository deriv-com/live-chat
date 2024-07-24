import 'package:live_chat/src/live_chat_platform_interface.dart';

class LiveChat {
  static final LiveChat _singleton = LiveChat._internal();

  factory LiveChat() {
    return _singleton;
  }

  LiveChat._internal();

  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) async {
    return LiveChatPlatform.instance.openChatWindow(
      licenseId: licenseId,
      username: username,
      email: email,
      groupId: groupId,
      customParameters: customParameters,
    );
  }

  Future<void> closeChatWindow() async {
    return LiveChatPlatform.instance.closeChatWindow();
  }

  Future<void> clearChatSession() async {
    return LiveChatPlatform.instance.clearChatSession();
  }

  Stream<dynamic>? get onLiveChatEventReceived =>
      LiveChatPlatform.instance.getLiveChatEventsStream();
}
