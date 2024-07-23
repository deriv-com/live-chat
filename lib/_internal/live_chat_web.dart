import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:live_chat/src/js/js_helper_web.dart';
import 'package:live_chat/src/live_chat_platform_interface.dart';

/// A web implementation of the LiveChatPlatform of the LiveChat plugin.
class LiveChatWeb extends LiveChatPlatform {
  LiveChatWeb();

  static void registerWith(Registrar registrar) {
    LiveChatPlatform.instance = LiveChatWeb();
  }

  final JSHelper _jsHelper = JSHelper();

  @override
  Future<void> openChatView({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) async {
    _jsHelper.callStartLiveChat(licenseId, username, email);
  }

  @override
  Stream? getEventsStream() {
    return null;
  }
}
