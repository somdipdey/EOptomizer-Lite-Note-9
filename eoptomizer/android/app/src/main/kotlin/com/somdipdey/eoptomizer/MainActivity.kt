package com.somdipdey.eoptomizer
import android.content.*
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.content.Intent
import java.lang.Compiler.command




class MainActivity: FlutterActivity() {


    private val BATTERY_CHANNEL = "com.somdipdey.eoptomizer/frequency"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "setFrequencyLevelCPU0Max" || call.method == "setFrequencyLevelCPU4Max" || call.method == "setFrequencyLevelCPU6Max" || call.method == "setFrequencyLevelCPU0Min" || call.method == "setFrequencyLevelCPU4Min" || call.method == "setFrequencyLevelCPU6Min") {
                setFrequencyLevelCPU0Max()
                setFrequencyLevelCPU4Max()
                setFrequencyLevelCPU6Max()
                setFrequencyLevelCPU0Min()
                setFrequencyLevelCPU4Min()
                setFrequencyLevelCPU6Min()
                result.success("Optimizing frequencies on CPU0, CPU4, CPU6")
            }

        }
    }
    fun setFrequencyLevelCPU0Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1598000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU4Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1663000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU6Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1745000 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU0Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU4Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU6Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 500000 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq")
        process.waitFor()
    }

}
