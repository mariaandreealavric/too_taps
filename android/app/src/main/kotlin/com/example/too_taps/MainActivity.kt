package com.example.too_taps

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private lateinit var unrealCommandChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        flutterEngine.platformViewsController.registry.registerViewFactory(
            "unreal_texture_view",
            UnrealTextureViewFactory(this)
        )

        unrealCommandChannel = MethodChannel(messenger, "flutter_unreal")
        unrealCommandChannel.setMethodCallHandler { call, result ->
            handleUnrealMethod(call, result)
        }

        UnrealEventDispatcher.eventsChannel = MethodChannel(
            messenger,
            "com.yourapp/native_events"
        )
    }

    private fun handleUnrealMethod(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "shatterStatue" -> {
                UnrealActivity.sendCommandToUnreal("ShatterStatue")
                result.success(null)
            }
            "changeStatue" -> {
                UnrealActivity.sendCommandToUnreal("ChangeStatue")
                result.success(null)
            }
            "resetStatue" -> {
                UnrealActivity.sendCommandToUnreal("ResetStatue")
                result.success(null)
            }
            "saveData" -> {
                UnrealActivity.sendCommandToUnreal("SaveData")
                result.success(null)
            }
            "handleTap" -> {
                val payload = call.arguments as? Map<String, Any?>
                UnrealActivity.sendCommandToUnreal("Tap", payload)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }
}
