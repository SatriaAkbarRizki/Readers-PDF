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
            val realPath = getRealPathFromUri(this, pdfUri)
            sharedText = realPath
        }
    }

    private fun getRealPathFromUri(context: Context, uri: Uri): String? {
        var realPath: String? = null
        when (uri.scheme) {
            "content" -> {
                val projection = arrayOf(OpenableColumns.DISPLAY_NAME)
                context.contentResolver.query(uri, projection, null, null, null)?.use { cursor ->
                    if (cursor.moveToFirst()) {
                        val columnIndex = cursor.getColumnIndexOrThrow(OpenableColumns.DISPLAY_NAME)
                        val fileName = cursor.getString(columnIndex)
                        realPath = copyFileToInternalStorage(context, uri, fileName)
                    }
                }
            }
            "file" -> {
                realPath = uri.path
            }
        }
        if (realPath == null) {
            val fileName = getFileName(context, uri)
            realPath = copyFileToInternalStorage(context, uri, fileName)
        }
        return realPath
    }

    private fun copyFileToInternalStorage(context: Context, uri: Uri, fileName: String): String? {
        val inputStream: InputStream? = context.contentResolver.openInputStream(uri)
        val file = File(context.filesDir, fileName)
        try {
            inputStream?.use { input ->
                FileOutputStream(file).use { output ->
                    val buffer = ByteArray(4 * 1024) // 4KB buffer
                    var read: Int
                    while (input.read(buffer).also { read = it } != -1) {
                        output.write(buffer, 0, read)
                    }
                    output.flush()
                }
            }
            return file.absolutePath
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return null
    }

    private fun getFileName(context: Context, uri: Uri): String {
        var name = "temp_file.pdf"
        context.contentResolver.query(uri, null, null, null, null)?.use { cursor ->
            if (cursor.moveToFirst()) {
                val index = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                if (index != -1) {
                    name = cursor.getString(index)
                }
            }
        }
        return name
    }

    
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_READ_STORAGE) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                handleIntent(intent)
            } else {
            
            }
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

    companion object {
        private const val REQUEST_READ_STORAGE = 100
    }
}
