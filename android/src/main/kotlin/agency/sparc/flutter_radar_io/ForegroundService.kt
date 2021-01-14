package agency.sparc.flutter_radar_io

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import io.radar.sdk.Radar
import io.radar.sdk.RadarTrackingOptions

class ForegroundService : Service() {

    override fun onCreate() {
        super.onCreate()
        val trackingOptions: RadarTrackingOptions =
                RadarTrackingOptions(
                        15, // desiredStoppedUpdateInterval
                        15, // fastestStoppedUpdateInterval
                        2, // desiredMovingUpdateInterval
                        2, // fastestMovingUpdateInterval
                        2, // desiredSyncInterval
                        RadarTrackingOptions.RadarTrackingOptionsDesiredAccuracy
                                .HIGH, // desiredAccuracy
                        1, // stopDuration
                        50, // stopDistance
                        null, // startTrackingAfter
                        null, // stopTrackingAfter
                        RadarTrackingOptions.RadarTrackingOptionsReplay.NONE, // replay
                        RadarTrackingOptions.RadarTrackingOptionsSync.STOPS_AND_EXITS, // sync
                        false, // useStoppedGeofence
                        0, // stoppedGeofenceRadius
                        false, // useMovingGeofence
                        0, // movingGeofenceRadius
                        true // sync geofence from server to client
                )
        Radar.startTracking(trackingOptions)
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        createNotificationChannel()
        val notificationIntent = Intent()
        val pendingIntent: PendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, 0)
        val notification =
                NotificationCompat.Builder(this, CHANNEL_ID)
                        .setContentTitle("Foreground Service")
                        .setContentText("input")
                        .setContentIntent(pendingIntent)
                        .build()
        startForeground(1, notification)
        // do heavy work on a background thread
        // stopSelf();
        return START_NOT_STICKY
    }

    @Override
    override fun onDestroy() {
        super.onDestroy()
        stopForeground(true)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel =
                    NotificationChannel(
                            CHANNEL_ID,
                            "Foreground Service Channel",
                            NotificationManager.IMPORTANCE_DEFAULT)
            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }

    companion object {
        const val CHANNEL_ID = "ForegroundServiceChannel"
    }
}
