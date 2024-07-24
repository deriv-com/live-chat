import 'js_library.dart';

class JSHelper {
  void callStartLiveChat(String licence, String userName, String email) {
    startLiveChat(licence, userName, email);
  }

  void callHideWindow() {
    hideWindow();
  }

  void callDestroyWindow() {
    destroyWindow();
  }
}
