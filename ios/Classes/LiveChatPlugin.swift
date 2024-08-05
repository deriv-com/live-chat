import Flutter
import UIKit
import LiveChat

public class LiveChatPlugin: NSObject, FlutterPlugin, LiveChatDelegate, FlutterStreamHandler {
    
    static let LIVE_CHAT_METHOD_CHANNEL = "live_chat/channel"
    static let LIVE_CHAT_EVENT_CHANNEL = "live_chat/events"
    let OPEN_CHAT_WINDOW = "open_chat_window"
    let CLOSE_CHAT_WINDOW = "close_chat_window"
    let CLEAR_CHAT_SESSION = "clear_chat_session"
    
    private var lifecycleSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: LIVE_CHAT_METHOD_CHANNEL, binaryMessenger: registrar.messenger())
        
        let _liveChatEventChannel = FlutterEventChannel(name: LIVE_CHAT_EVENT_CHANNEL, binaryMessenger: registrar.messenger())
        
        let instance = LiveChatPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        _liveChatEventChannel.setStreamHandler(instance.self)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case OPEN_CHAT_WINDOW:
            let arguments = call.arguments as! [String: Any]
            let licenseId = (arguments["licenseId"] as? String)
            let visitorName = (arguments["visitorName"] as? String)
            let visitorEmail = (arguments["visitorEmail"] as? String)
            let groupId = (arguments["groupId"] as? String)
            let customParams = (arguments["customParams"] as? [String: String])
            
            if licenseId == "" {
                result(FlutterError(code: "", message: "LICENSE NUMBER EMPTY", details: nil))
            } else {
                LiveChat.licenseId = licenseId
                LiveChat.name = visitorName
                LiveChat.email = visitorEmail
                LiveChat.groupId = groupId
                
                if(customParams != nil) {
                    for (key, value) in customParams! {
                        LiveChat.setVariable(withKey: key, value: value)
                    }
                }
                
                LiveChat.delegate = self
                LiveChat.customPresentationStyleEnabled = false
                
                LiveChat.presentChat()
                
                //Change colour of top and bottom notch for dark theme.
                let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
                UIView.transition(with: window!.rootViewController!.view, duration: 1, options: .transitionCrossDissolve, animations: {
                    let colorComponent = 37.0 / 255.0
                    window?.rootViewController?.view.backgroundColor = UIColor(red: colorComponent, green: colorComponent, blue: colorComponent, alpha: 1)}, completion: nil)
                
                result(nil)
            }
        case CLOSE_CHAT_WINDOW:
            LiveChat.dismissChat()
            result(nil)
        case CLEAR_CHAT_SESSION:
            LiveChat.clearSession()
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func received(message: LiveChatMessage) {
        lifecycleSink?(message.text)
    }
    
    public func chatPresented() {
        lifecycleSink?("chatOpen")
    }
    
    public func chatDismissed() {
        lifecycleSink?("chatClose")
    }
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        lifecycleSink = events
        
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        lifecycleSink = nil
        
        return nil
    }
}
