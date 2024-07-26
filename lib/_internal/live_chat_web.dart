import 'dart:async';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:live_chat_plus/src/js/js_helper_web.dart';
import 'package:live_chat_plus/src/js/js_library.dart';
import 'package:live_chat_plus/src/live_chat_platform_interface.dart';
import 'package:js/js_util.dart' as js;

/// A web implementation of the LiveChatPlatform of the LiveChat plugin.
class LiveChatWeb extends LiveChatPlatform {
  LiveChatWeb();

  static void registerWith(Registrar registrar) {
    LiveChatPlatform.instance = LiveChatWeb();
  }

  final JSHelper _jsHelper = JSHelper();
  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();

  @override
  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) async {
    _jsHelper.callStartLiveChat(licenseId, username, email);
  }

  @override
  Stream? getLiveChatEventsStream() {
    eventProducer.on('event', js.allowInterop((data) {
      _streamController.add(data);
    }));
    return _streamController.stream;
  }

  @override
  Future<void> closeChatWindow() async {
    _jsHelper.callHideWindow();
  }

  @override
  Future<void> clearChatSession() async {
    _jsHelper.callDestroyWindow();
  }
}
