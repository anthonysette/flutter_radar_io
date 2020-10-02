package agency.sparc.flutter_radar_io

import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import org.json.JSONObject

import android.Manifest
import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.ContextWrapper
import android.location.Location
import android.util.Log
import android.content.Intent
import android.content.IntentFilter

import java.lang.Runnable
import java.util.ArrayList
import java.util.HashMap
import java.util.List
import java.util.Map

import com.google.gson.Gson
import java.lang.reflect.Type;
import com.google.gson.reflect.TypeToken;

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.annotation.PropertyAccessor;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import io.radar.sdk.Radar
import io.radar.sdk.RadarReceiver
import io.radar.sdk.RadarTrackingOptions
import io.radar.sdk.model.RadarEvent
import io.radar.sdk.model.RadarUser

import agency.sparc.flutter_radar_io.MyRadarReceiver


/** FlutterRadarIoPlugin */
public class FlutterRadarIoPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null;
  private var context: Context? = null;

  val mapper = jacksonObjectMapper()
  val gson = Gson()


  fun setContext(context: Context) {
    this.context = context;
  }

  fun getContext(): Context? {
    return this.context;
  }

  override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  override fun onDetachedFromActivity() {
    this.activity = null;
  }


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.context = flutterPluginBinding.getApplicationContext();
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_radar_io")
    channel.setMethodCallHandler(this);
  }

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
    mapper.setVisibility(PropertyAccessor.FIELD, Visibility.ANY);
    val json = mapper.writeValueAsString(this)
    return mapper.readValue(json, R::class.java)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_radar_io")
      val plugin: FlutterRadarIoPlugin = FlutterRadarIoPlugin();
      plugin.setContext(registrar.context());
      channel.setMethodCallHandler(plugin);
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    try{
      when(call.method) {
        "initialize" -> {
          val publishableKey: String? = call.argument("publishableKey")
          Radar.initialize(this.context, publishableKey)
          Radar.setLogLevel(Radar.RadarLogLevel.DEBUG)
          result.success(true)
        }
        "set-log-level" -> {
          val level: String? = call.argument("level")
          when(level) {
            "debug" -> {
              Radar.setLogLevel(Radar.RadarLogLevel.DEBUG);
              result.success(true)
            }
            "error" -> {
              Radar.setLogLevel(Radar.RadarLogLevel.ERROR);
              result.success(true)
            }
            "info" -> {
              Radar.setLogLevel(Radar.RadarLogLevel.INFO);
              result.success(true)
            }
            "none" -> {
              Radar.setLogLevel(Radar.RadarLogLevel.NONE);
              result.success(true)
            }
            "warning" -> {
              Radar.setLogLevel(Radar.RadarLogLevel.WARNING);
              result.success(true)
            }
            else -> {
              Radar.setLogLevel(Radar.RadarLogLevel.NONE);
              result.success(true)
            }
          }
        }
        "set-user-id" -> {
          val uid: String? = call.argument("uid")
          Radar.setUserId(uid)
          result.success(true)
        }
        "get-user-id" -> {
          val uid: String? = Radar.getUserId()
          result.success(uid)
        }
        "set-metadata" -> {
          val meta: HashMap<String,Any>? = call.argument("meta")
          val metaJSON: JSONObject? = JSONObject(meta)
          Radar.setMetadata(metaJSON)
          result.success(true)
        }
        "get-metadata" -> {
          val metaJSON: JSONObject? = Radar.getMetadata()
          result.success(metaJSON.toString())
        }
        "set-description" -> {
          val description: String? = call.argument("description")
          Radar.setDescription(description)
          result.success(true)
        }
        "get-description" -> {
          val description: String? = Radar.getDescription();
          result.success(description)
        }
        "track-once" -> {
          Radar.trackOnce { status, location, events, user ->
            try {
              activity!!.runOnUiThread (
                object : Runnable {
                  override fun run() {
                    var args : HashMap<String, Any> = HashMap<String, Any> () 
                    args.put("status", status.toString());
                    args.put("location", location.toMap());
                    if (events != null && events.size > 0) {
                      val eventsList = ArrayList<Map<String, Any>>();
                      for (event in events) {
                        println(event)
                        eventsList.add(event.toMap());
                      }
                      args.put("events", eventsList);
                    }
                    args.put("user", user.toMap());
                    val json: JSONObject = JSONObject(args)
                    result.success(json.toString())
                  }
                }
              )
            }
            catch(e: Exception) {
              println(e);
            }
          }
        }
        "start-tracking" -> {
          val mode: String? = call.argument("mode");
          when(mode) {
            "efficient" -> {
              Radar.startTracking(RadarTrackingOptions.EFFICIENT)
              result.success(true)
            }
            "responsive" -> {
              Radar.startTracking(RadarTrackingOptions.RESPONSIVE)
              result.success(true)
            }
            "continuous" -> {
              Radar.startTracking(RadarTrackingOptions.CONTINUOUS)
              result.success(true)
            }
            else -> {
              result.success(false)
            }
          }
        }
        "stop-tracking" -> {
          Radar.stopTracking()
          result.success(true)
        }
        "is-tracking" -> {
          val isTracking: Boolean? = Radar.isTracking()
          result.success(isTracking)
        }
        else -> {
          result.notImplemented()
        }

      }
    } catch (e: Exception) {
      println("An error has occurred. Contact the developer for more information.")
      println(e)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    this.context = null;
    channel.setMethodCallHandler(null)
  }
}
