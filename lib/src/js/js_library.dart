import 'package:js/js.dart';

/// Producer class that will be called in javascript.
@JS()
class EventProducer {
  /// Triggers whenever a new event is emit in javascript. It should be listened
  /// to in dart.
  external void on(String event, Function listener);
}

/// Exposes [eventProducer].
@JS('window.eventProducer')
external EventProducer get eventProducer;

/// Triggers opening web live chat.
@JS()
external void startLiveChat(String licence, String userName, String email);

/// Triggers hiding web live chat.
@JS()
external void hideWindow();

/// Triggers destroying web live chat.
@JS()
external void destroyWindow();
