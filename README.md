<p style="text-align: left;">
<a href="https://pub.dev/packages/live_chat"><img src="https://img.shields.io/pub/v/live_chat.svg" alt="Pub"></a>
</p>

# live-chat
LiveChat is a plugin that brings [LiveChat](https://www.livechat.com/) functionality to Flutter Mobile and Web.

## Installation
First, add `live_chat` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Android

Step 1: Include JitPack repository in your Project-level build.gradle file:
```groovy
allprojects {
    repositories {
        .
        .
        .
        maven { url 'https://jitpack.io' }
    }
}
```
Step 2: Ensure you have added Internet permission in AndroidManifest.xml file:
```xml
 <uses-permission android:name="android.permission.INTERNET"/>
```

Step 3: To avoid issues with proguard enabled, include the following to proguard.pro file:
```
-keep class com.livechatinc.inappchat.** { *; }
```

### iOS 
Nothing is needed.

### Web
Inside index.html file, add this line inside `<head></head>` tag:
```html
 <script src="./packages/live_chat/src/js/live_chat.js" defer></script>
```

## Usage
- To start, import the following:

```dart
import 'package:live_chat/live_chat.dart';
```

- To open the chat window, call openChatView as follows:

```dart
    await LiveChat().openChatView(
      licenseId: '<LICENSE ID>',
      username: '<USERNAME>',
      email: '<EMAIL>',
      groupId: '<GROUP ID>',
      customParameters: <String, String>{'CUSTOM KEY': 'CUSTOM VALUE'},
    );
```

- You can subscribe to an event stream to listen to events coming from livechat. This is not supported in web at the moment.

```dart
LiveChat().onEventReceived?.listen((event) {
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

- In mobile, you call close the chat window and clear the current chat session as follows:

```dart
LiveChat().closeChatView();
LiveChat().clearChatView();
```

## Sample App
Refer to the **example** folder for a working app. Just ensure you have a valid license id.
