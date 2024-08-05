import 'package:live_chat_plus/src/live_chat_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// LiveChatPlatform contract.
abstract class LiveChatPlatform extends PlatformInterface {
  /// Constructs the contract.
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

  /// Open the chat window.
  Future<void> openChatWindow({
    required String licenseId,
    required String username,
    required String email,
    String? groupId,
    Map<String, String>? customParameters,
  }) {
    throw UnimplementedError('openChatWindow() has not been implemented.');
  }

  /// Close the chat window.
  Future<void> closeChatWindow() {
    throw UnimplementedError('closeChatWindow() has not been implemented.');
  }

  /// Clea the chat session.
  Future<void> clearChatSession() {
    throw UnimplementedError('clearChatSession() has not been implemented.');
  }

  /// Get the live chat events stream.
  Stream<dynamic>? getLiveChatEventsStream() {
    throw UnimplementedError(
        'getLiveChatEventsStream() has not been implemented.');
  }
}
