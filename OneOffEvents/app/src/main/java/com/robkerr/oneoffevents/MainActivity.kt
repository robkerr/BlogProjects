package com.robkerr.oneoffevents

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.robkerr.oneoffevents.ui.theme.AndroidOneOffEventsTheme
import com.robkerr.oneoffevents.views.AppMainView
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidOneOffEventsTheme {
               AppMainView()
            }
        }
    }
}