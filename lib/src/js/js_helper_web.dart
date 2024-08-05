import 'js_library.dart';

/// Helper class that handles calling external functions triggered with
/// javascript.
class JSHelper {
  /// Calls to open live chat window.
  void callStartLiveChat(String licence, String userName, String email) {
    startLiveChat(licence, userName, email);
  }

  /// Calls to close live chat window.
  void callHideWindow() {
    hideWindow();
  }

  /// Call to destroy live chat.
  void callDestroyWindow() {
    destroyWindow();
  }
}
