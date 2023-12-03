package com.example.ontas_smartwatch

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import android.os.Looper

class MainActivity: FlutterActivity() {

    private lateinit var locationCallback: LocationCallback
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private lateinit var methodChannel: MethodChannel

    private val channelName = "com.ontas/locations"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)

        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "startLocationService") {
                startLocationUpdates()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startLocationUpdates() {
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)

        // localization rate
        val locationRequest = LocationRequest.create().apply {
            interval = 10000
            fastestInterval = 5000
            priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        }

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                for (location in locationResult.locations) {

                    // get latitude and longitude as a HashMap
                    val locationMap = hashMapOf<String, Double>(
                        "latitude" to location.latitude,
                        "longitude" to location.longitude
                    )

                    // send both coordinates to flutter
                    methodChannel.invokeMethod("locationUpdate", locationMap)
                }
            }
        }

        fusedLocationClient.requestLocationUpdates(locationRequest, locationCallback, Looper.getMainLooper())
    }
}
