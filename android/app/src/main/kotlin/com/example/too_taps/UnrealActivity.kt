package com.example.too_taps

import android.graphics.SurfaceTexture
import android.os.Bundle
import android.view.TextureView
import android.view.View
import com.epicgames.unreal.GameActivity
import org.json.JSONObject

class UnrealActivity : GameActivity(), TextureView.SurfaceTextureListener {

    private lateinit var textureView: TextureView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        textureView = TextureView(this).apply {
            surfaceTextureListener = this@UnrealActivity
            systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_FULLSCREEN
                    or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
        }

        setContentView(textureView)
    }

    override fun onSurfaceTextureAvailable(surface: SurfaceTexture, width: Int, height: Int) {
        nativeSetRenderTarget(surface) // Passa la texture a Unreal Engine
        UnrealEventDispatcher.notifyStatueState(
            status = "Unreal pronta",
            destroyed = false,
            taps = 0,
            state = "ready"
        )
    }

    override fun onSurfaceTextureSizeChanged(surface: SurfaceTexture, width: Int, height: Int) {}
    override fun onSurfaceTextureDestroyed(surface: SurfaceTexture): Boolean = true
    override fun onSurfaceTextureUpdated(surface: SurfaceTexture) {}

    companion object {
        private var currentSurface: SurfaceTexture? = null

        fun attachSurface(surface: SurfaceTexture) {
            currentSurface = surface
            nativeSetRenderTarget(surface)
            UnrealEventDispatcher.notifyStatueState("Unreal pronta", false, 0, "ready")
        }

        fun detachSurface() {
            currentSurface = null
        }

        fun sendCommandToUnreal(event: String, payload: Map<String, Any?>? = null) {
            val jsonPayload = payload?.let { JSONObject(it).toString() }
            nativeSendEvent(event, jsonPayload)
        }

        fun notifyStatueState(status: String, destroyed: Boolean, taps: Int, state: String? = null) {
            UnrealEventDispatcher.notifyStatueState(status, destroyed, taps, state)
        }

        // Funzione nativa che Unreal Engine implementerà
        @JvmStatic
        private external fun nativeSendEvent(event: String, payload: String? = null)

        @JvmStatic
        private external fun nativeSetRenderTarget(surface: SurfaceTexture)
    }
}
