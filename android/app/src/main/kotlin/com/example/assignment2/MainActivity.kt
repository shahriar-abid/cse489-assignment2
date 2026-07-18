package com.example.assignment2

import android.content.*
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.example.assignment2/battery"
    private val CUSTOM_BROADCAST_TRIGGER = "com.example.assignment2/custom_broadcast_trigger"
    private val CUSTOM_BROADCAST_RECEIVER = "com.example.assignment2/custom_broadcast_receiver"
    private val CUSTOM_ACTION = "com.example.assignment2.CUSTOM_MESSAGE"

    private var batteryReceiver: BroadcastReceiver? = null
    private var customMessageReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 1. Battery Event Channel
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    batteryReceiver = createBatteryReceiver(events)
                    val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                    registerReceiver(batteryReceiver, filter)
                }

                override fun onCancel(arguments: Any?) {
                    if (batteryReceiver != null) {
                        unregisterReceiver(batteryReceiver)
                        batteryReceiver = null
                    }
                }
            }
        )

        // 2. Custom Broadcast Trigger (MethodChannel to send broadcast)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CUSTOM_BROADCAST_TRIGGER).setMethodCallHandler { call, result ->
            if (call.method == "sendCustomBroadcast") {
                val message = call.argument<String>("message")
                val intent = Intent(CUSTOM_ACTION)
                intent.putExtra("message", message)
                sendBroadcast(intent)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        // 3. Custom Broadcast Receiver (EventChannel to send back to Flutter)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CUSTOM_BROADCAST_RECEIVER).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    customMessageReceiver = object : BroadcastReceiver() {
                        override fun onReceive(context: Context?, intent: Intent?) {
                            if (intent?.action == CUSTOM_ACTION) {
                                val msg = intent.getStringExtra("message")
                                events?.success(msg)
                            }
                        }
                    }
                    val filter = IntentFilter(CUSTOM_ACTION)
                    
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        registerReceiver(customMessageReceiver, filter, Context.RECEIVER_EXPORTED)
                    } else {
                        registerReceiver(customMessageReceiver, filter)
                    }
                }

                override fun onCancel(arguments: Any?) {
                    if (customMessageReceiver != null) {
                        unregisterReceiver(customMessageReceiver)
                        customMessageReceiver = null
                    }
                }
            }
        )
    }

    private fun createBatteryReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                if (intent?.action == Intent.ACTION_BATTERY_CHANGED) {
                    val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
                    val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
                    val batteryPct = if (level != -1 && scale != -1) (level * 100 / scale.toFloat()).toInt() else -1
                    
                    val data = mutableMapOf<String, Any>()
                    data["level"] = batteryPct
                    events?.success(data)
                }
            }
        }
    }
}
