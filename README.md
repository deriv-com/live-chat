<p style="text-align: left;">
<a href="https://pub.dev/packages/live_chat_plus"><img src="https://img.shields.io/pub/v/live_chat_plus.svg" alt="Pub"></a>
</p>

# live_chat_plus
LiveChat is a plugin that brings [LiveChat](https://www.livechat.com/) functionality to Flutter Mobile and Web.

## Installation
First, add `live_chat_plus` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Android

Step 1: Ensure you have added Internet permission in AndroidManifest.xml file:
```xml
 <uses-permission android:name="android.permission.INTERNET"/>
```

Step 2: To avoid issues with proguard enabled, include the following to proguard.pro file:
```
-keep class com.livechatinc.inappchat.** { *; }
```

### Web
Inside index.html file, add this line inside `<head></head>` tag:
```html
 <script src="./assets/packages/live_chat_plus/assets/live_chat.js" defer></script>
```

## Usage
- To start, import the following:

```dart
import 'package:live_chat_plus/live_chat_plus.dart';
```

- To open the chat window, call openChatView as follows:

```dart
    await LiveChat().openChatWindow(
      licenseId: '<LICENSE ID>',
      username: '<USERNAME>',
      email: '<EMAIL>',
      groupId: '<GROUP ID>',
      customParameters: <String, String>{'CUSTOM KEY': 'CUSTOM VALUE'},
    );
```

- You can subscribe to an event stream to listen to events coming from livechat.

```dart
LiveChat().onLiveChatEventReceived?.listen((event) {
      switch (event) {
        case 'chatOpen':
          break;
        case 'chatClose':
          break;

        default:
         // Messages - You can handle notification badge counts for example here.
      }
    });
```

- You call close the chat window by simply calling:

```dart
LiveChat().closeChatWindow();
```

- In order to clear the session in mobile, for example, after logging out, you can call:

```dart
LiveChat().clearChatSession();
```

This will call [destroy](https://platform.text.com/docs/extending-chat-widget/javascript-api#destroy) on web.

## Sample App
Refer to the [example](https://github.com/deriv-com/live-chat/tree/master/example) folder for a working app. Just ensure you have a valid license id.
