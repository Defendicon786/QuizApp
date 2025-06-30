package com.example.quizapp

import android.os.Bundle
import android.webkit.WebView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val webView: WebView = findViewById(R.id.web_view)
        webView.settings.javaScriptEnabled = true
        // Change the URL to your server hosting the PHP app
        webView.loadUrl("http://10.0.2.2/index.php")
    }
}
