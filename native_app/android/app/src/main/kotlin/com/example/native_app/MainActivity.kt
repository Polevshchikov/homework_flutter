package com.example.native_app

import android.Manifest
import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.os.Looper
import androidx.annotation.NonNull
import android.location.Address
import android.location.Geocoder
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
//import com.google.android.gms.location.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit


class MainActivity: FlutterActivity() {
    private val STREAM = "examples.dev/location_events"
    private val CHANNEL = "examples.dev/location"
    var addresses: List<Address>? = null
    lateinit var geocoder : Geocoder

    lateinit var locationManager : LocationManager
    var rootObject = JSONObject()

    lateinit var listener : LocationListener

    @SuppressLint("ServiceCast")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        locationManager = getSystemService(LOCATION_SERVICE) as LocationManager

        if (ContextCompat.checkSelfPermission(this@MainActivity,
                        Manifest.permission.ACCESS_FINE_LOCATION) !==
                PackageManager.PERMISSION_GRANTED) {
            if (ActivityCompat.shouldShowRequestPermissionRationale(
                            this@MainActivity,
                            Manifest.permission.ACCESS_FINE_LOCATION
                    )
            ) {
                ActivityCompat.requestPermissions(
                        this@MainActivity,
                        arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 1
                )
            } else {
                ActivityCompat.requestPermissions(
                        this@MainActivity,
                        arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), 1
                )
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>,
                                            grantResults: IntArray) {
        when (requestCode) {
            1 -> {
                if (grantResults.isNotEmpty() && grantResults[0] ==
                        PackageManager.PERMISSION_GRANTED) {
                    if ((ContextCompat.checkSelfPermission(this@MainActivity,
                                    Manifest.permission.ACCESS_FINE_LOCATION) ===
                                    PackageManager.PERMISSION_GRANTED)) {
                    }
                } else {
                    
                }
                return
            }
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "startLocationService") {
                if (ActivityCompat.checkSelfPermission(
                                context,
                                Manifest.permission.ACCESS_FINE_LOCATION
                        ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                                context,
                                Manifest.permission.ACCESS_COARSE_LOCATION
                        ) == PackageManager.PERMISSION_GRANTED
                ) {

                    locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, call.arguments(), listener)

                }
                result.success("Выполнено")
            } else if (call.method == "stopLocationService")
            {
                locationManager.removeUpdates(listener)
                result.success("Выполнено")
            } else {
                result.notImplemented()
            }
        }

        geocoder  = Geocoder(this, Locale.getDefault() )

        EventChannel(flutterEngine?.dartExecutor, STREAM).setStreamHandler(
                object : EventChannel.StreamHandler {

                    override fun onListen(args: Any?, events: EventSink) {
                        listener = LocationListener { location ->
                            try {
                                addresses = geocoder.getFromLocation(location.latitude, location.longitude, 1)
                            } catch (ioException: Exception) {
                                Log.e("", "Error in getting address for the location")
                            }
                            var country = addresses?.get(0)?.countryName;
                            var region = addresses?.get(0)?.adminArea;
                            var city = addresses?.get(0)?.locality;
                            var postalCode = addresses?.get(0)?.postalCode;
                            var street = addresses?.get(0)?.thoroughfare;
                            var houseNum = addresses?.get(0)?.subThoroughfare;
                            var latitude = location.latitude;
                            var longitude = location.longitude;

                            rootObject = JSONObject()

                            rootObject.put("country", country);
                            rootObject.put("region", region);
                            rootObject.put("city", city);
                            rootObject.put("postalCode", postalCode);
                            rootObject.put("street", street);
                            rootObject.put("houseNum", houseNum);
                            rootObject.put("latitude", latitude);
                            rootObject.put("longitude", longitude);

                            events.success(rootObject.toString())
                        }
                    }


                    override fun onCancel(args: Any?) {
                    }
                })
    }
}
