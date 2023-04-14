package com.robkerr.oneoffevents

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class OneOffEventsApp : Application() {
    override fun onCreate() {
        super.onCreate()
    }
}