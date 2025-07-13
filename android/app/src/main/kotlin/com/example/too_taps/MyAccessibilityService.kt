package com.example.too_taps

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.util.Log
import io.flutter.plugin.common.MethodChannel

class MyAccessibilityService : AccessibilityService() {
    private lateinit var channel: MethodChannel

    override fun onServiceConnected() {
        super.onServiceConnected()
        channel = MethodChannel(
            MainActivity.flutterEngineInstance.dartExecutor.binaryMessenger,
            "com.yourapp/native_events"
        )
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        when (event.eventType) {
            AccessibilityEvent.TYPE_VIEW_CLICKED -> {
                Log.d("AccessibilityService", "Tocco registrato su: ${event.className}")
                channel.invokeMethod("onTouchEvent", null)
            }
            AccessibilityEvent.TYPE_VIEW_SCROLLED -> {
                Log.d("AccessibilityService", "Scroll registrato su: ${event.className}")
                channel.invokeMethod("onScrollEvent", null)
            }
        }
    }

    override fun onInterrupt() {
        Log.d("AccessibilityService", "Servizio interrotto")
    }
}
