package com.example.too_taps

import android.graphics.SurfaceTexture
import android.os.Bundle
import android.view.TextureView
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.epicgames.unreal.GameActivity

class UnrealActivity : GameActivity(), TextureView.SurfaceTextureListener {

    private lateinit var textureView: TextureView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        textureView = TextureView(this)
        textureView.surfaceTextureListener = this
        textureView.systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
                or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)

        setContentView(textureView)
    }

    override fun onSurfaceTextureAvailable(surface: SurfaceTexture, width: Int, height: Int) {
        nativeSetRenderTarget(surface) // Passa la texture a Unreal Engine
    }

    override fun onSurfaceTextureSizeChanged(surface: SurfaceTexture, width: Int, height: Int) {}
    override fun onSurfaceTextureDestroyed(surface: SurfaceTexture): Boolean = true
    override fun onSurfaceTextureUpdated(surface: SurfaceTexture) {}

    companion object {
        fun sendEventToUnreal(event: String) {
            nativeSendEvent(event)
        }

        // Funzione nativa che Unreal Engine implementerà
        @JvmStatic
        private external fun nativeSendEvent(event: String)
    }
}
