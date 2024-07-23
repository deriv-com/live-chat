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

    subscription = LiveChat().onEventReceived?.listen((event) {
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

      LiveChat().closeChatView();
    }
  }

  void _setCounter(int counter) =>
      setState(() => _unreadNotificationCounter = counter);

  Future<void> openChatView() async {
    await LiveChat().openChatView(
      licenseId: '<LICENSE ID>',
      username: '<USERNAME>',
      email: '<EMAIL>',
      groupId: '<GROUP ID>',
      customParameters: <String, String>{'CUSTOM KEY': 'CUSTOM VALUE'},
    );

    _canGoBack = false;
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
                    : Container()
              ]),
            ],
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                    ),
                    child: TextButton(
                      onPressed: openChatView,
                      child: const Text(
                        'Start Live Chat',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
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
