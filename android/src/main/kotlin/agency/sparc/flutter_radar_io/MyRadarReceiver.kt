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

  fun createLocation(l: Location): HashMap<String, Any> {
    val loc: HashMap<String, Any> = HashMap()
    loc.put("latitude", l.getLatitude())
    loc.put("longitude", l.getLongitude())
    loc.put("accuracy", l.getAccuracy())
    loc.put("altitude", l.getAltitude())
    loc.put("speed", l.getSpeed())
    loc.put("time", l.getTime())
    return loc
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
    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onLocationUpdated(context: Context, location: Location, user: RadarUser) {
    println("location was updated")
    var args: HashMap<String, Any> = HashMap<String, Any>()
    val l = createLocation(location)
    args.put("location", l)
    val json: JSONObject = JSONObject(args)
    FlutterRadarIoPlugin.mEventSink?.success(json.toString())
  }

  override fun onClientLocationUpdated(context: Context, location: Location, stopped: Boolean, source: Radar.RadarLocationSource) {
    println("client location updated")
    var args: HashMap<String, Any> = HashMap<String, Any>()
    val l = createLocation(location)
    args.put("location", l)
    val json: JSONObject = JSONObject(args)
//    FlutterRadarIoPlugin.mEventSink?.success("client location works")
  }

  override fun onError(context: Context, status: Radar.RadarStatus) {
    println(status)
  }

  override fun onLog(context: Context, message: String) {
    println(message)
  }

}
