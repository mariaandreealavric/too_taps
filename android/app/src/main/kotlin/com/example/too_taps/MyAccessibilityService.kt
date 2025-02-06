package com.example.too_taps

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.util.Log

class MyAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        when (event.eventType) {
            AccessibilityEvent.TYPE_VIEW_CLICKED -> {
                Log.d("AccessibilityService", "Tocco registrato su: ${event.className}")
            }
            AccessibilityEvent.TYPE_VIEW_SCROLLED -> {
                Log.d("AccessibilityService", "Scroll registrato su: ${event.className}")
            }
        }
    }

    override fun onInterrupt() {
        Log.d("AccessibilityService", "Servizio interrotto")
    }
}
