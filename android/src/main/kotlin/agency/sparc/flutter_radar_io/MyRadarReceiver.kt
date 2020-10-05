package agency.sparc.flutter_radar_io

import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat

import android.Manifest
import android.app.Activity
import android.app.Application
import android.content.Context
import android.location.Location
import android.util.Log

import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter

import io.radar.sdk.Radar
import io.radar.sdk.RadarReceiver
import io.radar.sdk.RadarTrackingOptions
import io.radar.sdk.model.RadarEvent
import io.radar.sdk.model.RadarUser


public class MyRadarReceiver: RadarReceiver() {

  override fun onEventsReceived(context: Context, events: Array<RadarEvent>, user: RadarUser) {
    println("an event was received")
  }

  override fun onLocationUpdated(context: Context, location: Location, user: RadarUser) {
    println("location was updated")
  }

  override fun onClientLocationUpdated(context: Context, location: Location, stopped: Boolean, source: Radar.RadarLocationSource) {
    println("client location updated")
  }

  override fun onError(context: Context, status: Radar.RadarStatus) {
    println(status)
  }

  override fun onLog(context: Context, message: String) {
    println(message)
  }

}