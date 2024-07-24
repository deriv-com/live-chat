import 'dart:async';
import 'package:flutter/material.dart';
import 'package:live_chat/live_chat.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final StreamSubscription? subscription;

  bool _canGoBack = true;
  int _unreadNotificationCounter = 1;

  @override
  void initState() {
    super.initState();

    subscription = LiveChat().onLiveChatEventReceived?.listen((event) {
      switch (event) {
        case 'chatOpen':
          break;
        case 'chatClose':
          _canGoBack = true;
          break;

        default:
          _setCounter(++_unreadNotificationCounter);
      }
    });
  }

  Future<void> _onWillPop(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!_canGoBack) {
      _canGoBack = true;

      LiveChat().closeChatWindow();
    }
  }

  void _setCounter(int counter) =>
      setState(() => _unreadNotificationCounter = counter);

  Future<void> openChatView() async {
    await LiveChat().openChatWindow(
      licenseId: '<LICENSE ID>',
      username: '<USERNAME>',
      email: '<EMAIL>',
      groupId: '<GROUP ID>',
      customParameters: <String, String>{'CUSTOM KEY': 'CUSTOM VALUE'},
    );

    _canGoBack = false;
  }

  Future<void> closeChatView() async {
    await LiveChat().closeChatWindow();
  }

  Future<void> clearChatView() async {
    await LiveChat().clearChatSession();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: false,
        onPopInvoked: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text('Live Chat Demo'),
            actions: <Widget>[
              Stack(children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    _setCounter(1);

                    openChatView();
                  },
                ),
                _unreadNotificationCounter > 1
                    ? const Positioned(
                        // draw a red marble
                        top: 10,
                        right: 14,
                        child: Icon(
                          Icons.brightness_1,
                          size: 8,
                          color: Colors.redAccent,
                        ),
                      )
                    : const SizedBox.shrink()
              ]),
            ],
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Center(
                  child: ElevatedButton(
                    onPressed: openChatView,
                    child: const Text('Start Live Chat'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: closeChatView,
                    child: const Text('Close Live Chat'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: clearChatView,
                    child: const Text('Clear Chat Session'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }
}
