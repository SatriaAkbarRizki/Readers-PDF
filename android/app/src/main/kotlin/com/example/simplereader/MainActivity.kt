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
import android.database.Cursor


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
            val filePath = getRealPathFromURI(pdfUri)
            sharedText = filePath
        }
    }

    private fun getRealPathFromURI(uri: Uri): String? {
        var cursor: Cursor? = null
        try {
            cursor = contentResolver.query(uri, null, null, null, null)
            if (cursor != null && cursor.moveToFirst()) {
                val columnIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                val fileName = cursor.getString(columnIndex)
                if (uri.scheme == "content") {
                    val inputStream: InputStream? = contentResolver.openInputStream(uri)
                    val file = File(filesDir, fileName)
                    val outputStream = FileOutputStream(file)
                    inputStream?.copyTo(outputStream)
                    outputStream.close()
                    inputStream?.close()
                    return file.absolutePath
                } else if (uri.scheme == "file") {
                    return uri.path
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            cursor?.close()
        }
        return null
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
