package agency.sparc.flutter_radar_io

import android.content.Context
import android.location.Location
import io.radar.sdk.Radar
import io.radar.sdk.RadarReceiver
import io.radar.sdk.model.RadarEvent
import io.radar.sdk.model.RadarUser

import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility
import com.fasterxml.jackson.annotation.PropertyAccessor
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper

import java.util.HashMap
import java.util.Map
import org.json.JSONObject


class MyRadarReceiver : RadarReceiver() {

  val mapper = jacksonObjectMapper()

  // Convert a Map to an object
  inline fun <reified T> Map<String, Any>.toObject(): T {
    return convert()
  }

  // Convert an object to a Map
  fun <T> T.toMap(): Map<String, Any> {
    return convert()
  }

  // Convert an object of type T to type R
  inline fun <T, reified R> T.convert(): R {
    mapper.setVisibility(PropertyAccessor.FIELD, Visibility.ANY)
    val json = mapper.writeValueAsString(this)
    return mapper.readValue(json, R::class.java)
  }

  enum class EventType {
    EVENTS_RECEIVED,
    CLIENT_LOCATION_UPDATED,
    LOCATION_UPDATED,
    ERROR,
  }

  override fun onEventsReceived(context: Context, events: Array<RadarEvent>, user: RadarUser) {
    println("an event was received")
    var args: HashMap<String, Any> = HashMap<String, Any>()
    args.put("user", user.toMap())
    if (events != null && events.size > 0) {
      val eventsList = ArrayList<Map<String, Any>>()
      for (event in events) {
        eventsList.add(event.toMap())
      }
      args.put("events", eventsList)
    }
    args.put("eventType", EventType.EVENTS_RECEIVED.toString())

    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onLocationUpdated(context: Context, location: Location, user: RadarUser) {
    println("location was updated")
    var args: HashMap<String, Any> = HashMap<String, Any>()
    args.put("location", location.toMap())
    args.put("user", user.toMap())
    args.put("eventType", EventType.LOCATION_UPDATED.toString())

    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onClientLocationUpdated(context: Context, location: Location, stopped: Boolean, source: Radar.RadarLocationSource) {
    println("client location updated")
    var args: HashMap<String, Any> = HashMap<String, Any>()
    args.put("location", location.toMap())
    args.put("stopped", stopped)
    args.put("source", source)
    args.put("eventType", EventType.CLIENT_LOCATION_UPDATED.toString())


    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onError(context: Context, status: Radar.RadarStatus) {
    println(status)
    var args: HashMap<String, Any> = HashMap<String, Any>()
    args.put("status", status.toString())
    args.put("eventType", EventType.ERROR.toString())


    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onLog(context: Context, message: String) {
    println(message)
  }

}
