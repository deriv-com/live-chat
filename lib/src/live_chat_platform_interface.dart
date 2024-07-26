import 'package:live_chat_plus/src/live_chat_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class LiveChatPlatform extends PlatformInterface {
  LiveChatPlatform() : super(token: _token);

  static final Object _token = Object();

  static LiveChatPlatform _instance = MethodChannelLiveChat();

  /// The default instance of [LiveChatPlatform] to use.
  ///
  /// Defaults to [MethodChannelLiveChat].
  static LiveChatPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LiveChatPlatform] when
  /// they register themselves.
  static set instance(LiveChatPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) {
    throw UnimplementedError('openChatView() has not been implemented.');
  }

  Future<void> closeChatWindow() {
    throw UnimplementedError('closeChatView() has not been implemented.');
  }

  Future<void> clearChatSession() {
    throw UnimplementedError('clearChatView() has not been implemented.');
  }

  Stream<dynamic>? getLiveChatEventsStream() {
    throw UnimplementedError('getEventsStream() has not been implemented.');
  }
}
