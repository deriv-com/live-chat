import 'package:live_chat_plus/src/live_chat_platform_interface.dart';

/// Live Chat Plus plugin class.
class LiveChat {
  /// Constructs Livechat.
  factory LiveChat() => _singleton;

  LiveChat._internal();

  static final LiveChat _singleton = LiveChat._internal();

  /// Call to open the live chat window. It requires [licenseId], [username],
  /// and [email].
  /// In addition, optional [groupId] and [customParameters] can be passed if
  /// needed.
  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) async =>
      LiveChatPlatform.instance.openChatWindow(
        licenseId: licenseId,
        username: username,
        email: email,
        groupId: groupId,
        customParameters: customParameters,
      );

  /// Call to close/hide the chat window.
  Future<void> closeChatWindow() async =>
      LiveChatPlatform.instance.closeChatWindow();

  /// Call to clear the chat session, for example, after logout,
  Future<void> clearChatSession() async =>
      LiveChatPlatform.instance.clearChatSession();

  /// Subscribe to events stream coming from live chat windows such as:
  /// open, close, message, actual message text, etc.
  Stream<dynamic>? get onLiveChatEventReceived =>
      LiveChatPlatform.instance.getLiveChatEventsStream();
}
