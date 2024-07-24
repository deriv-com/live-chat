import 'package:js/js.dart';

@JS()
class EventProducer {
  external void on(String event, Function listener);
}

@JS('window.eventProducer')
external EventProducer get eventProducer;

@JS()
external void startLiveChat(String licence, String userName, String email);

@JS()
external void hideWindow();

@JS()
external void destroyWindow();
