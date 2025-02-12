package com.example.too_taps

import android.graphics.SurfaceTexture
import android.os.Bundle
import android.view.MotionEvent
import android.view.TextureView
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.epicgames.unreal.GameActivity

class UnrealActivity : GameActivity(), TextureView.SurfaceTextureListener {

    private lateinit var textureView: TextureView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Creiamo una TextureView per Unreal
        textureView = TextureView(this)
        textureView.surfaceTextureListener = this
        textureView.systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)

        // Imposta il listener per il tocco
        textureView.setOnTouchListener { _, event ->
            if (event.action == MotionEvent.ACTION_DOWN || event.action == MotionEvent.ACTION_MOVE) {
                sendTouchToUnreal(event.x.toDouble(), event.y.toDouble())
            }
            true
        }

        setContentView(textureView)
    }

    override fun onSurfaceTextureAvailable(surface: SurfaceTexture, width: Int, height: Int) {
        nativeSetRenderTarget(surface) // Passa la texture a Unreal Engine
    }

    override fun onSurfaceTextureSizeChanged(surface: SurfaceTexture, width: Int, height: Int) {}
    override fun onSurfaceTextureDestroyed(surface: SurfaceTexture): Boolean = true
    override fun onSurfaceTextureUpdated(surface: SurfaceTexture) {}

    companion object {
        fun sendTouchToUnreal(x: Double, y: Double) {
            // Logica per inviare il tocco a Unreal Engine (devi implementarlo in Unreal)
            nativeSendTouch(x, y)
        }

        // Funzione nativa che Unreal Engine implementerà
        @JvmStatic
        private external fun nativeSendTouch(x: Double, y: Double)
    }
}
