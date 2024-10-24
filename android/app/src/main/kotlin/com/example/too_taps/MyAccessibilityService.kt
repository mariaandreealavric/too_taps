package com.example.too_taps

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import io.flutter.plugin.common.MethodChannel

class MyAccessibilityService : AccessibilityService() {

    private lateinit var channel: MethodChannel

    override fun onServiceConnected() {
        super.onServiceConnected()
        // Configura il MethodChannel utilizzando l'istanza di FlutterEngine
        channel = MethodChannel(
            MainActivity.flutterEngineInstance.dartExecutor.binaryMessenger,
            "com.yourapp/native_events"
        )
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event != null) {
            when (event.eventType) {
                AccessibilityEvent.TYPE_TOUCH_INTERACTION_START -> {
                    channel.invokeMethod("onTouchEvent", null)
                }
                AccessibilityEvent.TYPE_VIEW_SCROLLED -> {
                    channel.invokeMethod("onScrollEvent", null)
                }
            }
        }
    }

    override fun onInterrupt() {
        // Gestione interruzioni del servizio di accessibilità
    }
}
