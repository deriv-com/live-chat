package com.deriv.livechat.live_chat

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.livechatinc.inappchat.ChatWindowConfiguration
import com.livechatinc.inappchat.ChatWindowErrorType
import com.livechatinc.inappchat.ChatWindowEventsListener
import com.livechatinc.inappchat.ChatWindowUtils
import com.livechatinc.inappchat.ChatWindowView
import com.livechatinc.inappchat.models.NewMessageModel

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener

/** LiveChatPlugin */
class LiveChatPlugin :
    FlutterPlugin,
    MethodCallHandler,
    ActivityAware,
    StreamHandler,
    ActivityResultListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private lateinit var context: Context
    private var lifecycleSink: EventSink? = null
    private var chatWindowView: ChatWindowView? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, LIVE_CHAT_METHOD_CHANNEL)
        channel.setMethodCallHandler(this)

        EventChannel(flutterPluginBinding.binaryMessenger, LIVE_CHAT_EVENT_CHANNEL)
            .setStreamHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            OPEN_LIVE_CHAT_VIEW -> {
                val licenseId = call.argument<String>("licenseId")
                val visitorName = call.argument<String>("visitorName")
                val visitorEmail = call.argument<String>("visitorEmail")
                val groupId = call.argument<String>("groupId")
                val customParams = call.argument<HashMap<String, String>?>("customParams")

                activity?.let {

                    val configuration = ChatWindowConfiguration.Builder()
                        .setLicenceNumber(licenseId)
                        .setVisitorName(visitorName)
                        .setVisitorEmail(visitorEmail)
                        .setGroupId(groupId)
                        .setCustomParams(customParams)
                        .build()


                    if (chatWindowView == null) {
                        chatWindowView = ChatWindowUtils.createAndAttachChatWindowInstance(it)

                        chatWindowView?.setConfiguration(configuration)
                        chatWindowView?.setEventsListener(object : ChatWindowEventsListener {
                            override fun onWindowInitialized() {
                                chatWindowView?.showChatWindow()
                            }

                            override fun onChatWindowVisibilityChanged(visible: Boolean) {
                                if (visible) {
                                    lifecycleSink?.success("chatOpen")
                                } else {
                                    lifecycleSink?.success("chatClose")
                                }
                            }

                            override fun onNewMessage(
                                message: NewMessageModel?,
                                windowVisible: Boolean
                            ) {
                                lifecycleSink?.success(message?.text)
                            }

                            override fun onStartFilePickerActivity(
                                intent: Intent?,
                                requestCode: Int
                            ) {
                                activity?.startActivityForResult(intent, requestCode)
                            }

                            override fun onRequestAudioPermissions(
                                permissions: Array<out String>?,
                                requestCode: Int
                            ) {
                            }

                            override fun onError(
                                errorType: ChatWindowErrorType?,
                                errorCode: Int,
                                errorDescription: String?
                            ): Boolean {
                                println("LiveChatPlugin: error ->> $errorDescription")
                                return true
                            }

                            override fun handleUri(uri: Uri?): Boolean {
                                return false
                            }

                        })
                        chatWindowView?.initialize()
                    }
                    chatWindowView?.showChatWindow()
                }
                result.success(null)
            }

            CLOSE_LIVE_CHAT_VIEW -> {
                chatWindowView?.setEventsListener(null)
                chatWindowView?.onBackPressed()
                chatWindowView = null

                result.success(null)
            }

            CLEAR_LIVE_CHAT_VIEW -> {
                ChatWindowUtils.clearSession(activity)
                chatWindowView?.reload(true)

                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        lifecycleSink = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        lifecycleSink = events
    }

    override fun onCancel(arguments: Any?) {
        lifecycleSink = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (chatWindowView != null) chatWindowView?.onActivityResult(requestCode, resultCode, data)
        return true
    }

    companion object {
        const val LIVE_CHAT_METHOD_CHANNEL = "live_chat/channel"
        const val LIVE_CHAT_EVENT_CHANNEL = "live_chat/events"
        const val OPEN_LIVE_CHAT_VIEW = "open_live_chat_view"
        const val CLOSE_LIVE_CHAT_VIEW = "close_live_chat_view"
        const val CLEAR_LIVE_CHAT_VIEW = "clear_live_chat_view"
    }
}
