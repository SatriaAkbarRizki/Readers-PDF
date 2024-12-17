package com.example.simplereader

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.OpenableColumns
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.InputStream

class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    private val CHANNEL = "com.example.simplereader"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_VIEW == action && type == "application/pdf") {
            handleViewPdf(intent)
        }
        
    }

    private fun handleViewPdf(intent: Intent) {
        val pdfUri: Uri? = intent.data
        if (pdfUri != null) {
            sharedText = pdfUri.toString()
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getSharedText") {
                    result.success(sharedText)
                    sharedText = null
                } else {
                    result.notImplemented()
                }
            }
    }
}
