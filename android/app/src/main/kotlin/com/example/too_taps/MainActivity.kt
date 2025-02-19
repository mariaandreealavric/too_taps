package com.example.too_taps

import android.content.Intent
import android.os.Bundle
import android.view.TextureView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterActivity() {
    companion object {
        lateinit var flutterEngineInstance: FlutterEngine
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngineInstance = flutterEngine

        // Registra il TextureView per Unreal Engine
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("unreal_texture_view", UnrealViewFactory(this))

        // Metodo per inviare eventi a Unreal Engine
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "flutter_unreal").setMethodCallHandler { call, result ->
            when (call.method) {
                "launchUE" -> {
                    val intent = Intent(this, UnrealActivity::class.java)
                    startActivity(intent)
                    result.success(null)
                }
                "shatterStatue" -> {
                    UnrealActivity.sendEventToUnreal("ShatterEvent")
                    result.success(null)
                }
                "changeStatue" -> {
                    UnrealActivity.sendEventToUnreal("ChangeStatueEvent")
                    result.success(null)
                }
                "resetStatue" -> {
                    UnrealActivity.sendEventToUnreal("ResetStatueEvent")
                    result.success(null)
                }
                "saveData" -> {
                    UnrealActivity.sendEventToUnreal("SaveDataEvent")
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}

// Classe per registrare il TextureView di Unreal
class UnrealViewFactory(private val context: Context) : PlatformViewFactory(null) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val textureView = TextureView(context)
        return object : PlatformView {
            override fun getView() = textureView
            override fun dispose() {}
        }
    }
}
