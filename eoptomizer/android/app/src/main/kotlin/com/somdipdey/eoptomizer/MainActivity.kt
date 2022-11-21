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
import android.widget.Toast
import java.lang.Compiler.command




class MainActivity: FlutterActivity() {


    private val OPTIMIZATION_CHANNEL = "com.somdipdey.eoptomizer/frequency"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, OPTIMIZATION_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "setFrequencyLevelCPU0Max" || call.method == "setFrequencyLevelCPU4Max" || call.method == "setFrequencyLevelCPU0Min" || call.method == "setFrequencyLevelCPU4Min") {
                var arguments = call.arguments() as Map<String,String>?
                var LITTLECPUMaxFreq = arguments?.get("LITTLECPUMaxFreq")?.toString() ?: "1766400"
                val bigCPUMaxFreq = arguments?.get("bigCPUMaxFreq")?.toString() ?: "2649600"
                setFrequencyLevelCPU0Max(LITTLECPUMaxFreq)
                setFrequencyLevelCPU4Max(bigCPUMaxFreq)
                setFrequencyLevelCPU0Min()
                setFrequencyLevelCPU4Min()
                val message = "Optimizing frequencies on CPU0 - $LITTLECPUMaxFreq, CPU4 - $bigCPUMaxFreq"
                Toast.makeText(this, message, Toast.LENGTH_LONG).show()
                result.success(message)
            }

            if (call.method == "setDefaultFrequencyLevelCPU0Max" || call.method == "setDefaultFrequencyLevelCPU4Max" || call.method == "setDefaultFrequencyLevelCPU0Min" || call.method == "setDefaultFrequencyLevelCPU4Min") {
                setDefaultFrequencyLevelCPU0Max()
                setDefaultFrequencyLevelCPU4Max()
                setDefaultFrequencyLevelCPU0Min()
                setDefaultFrequencyLevelCPU4Min()
                val message = "Setting default frequencies on CPU0, CPU4"
                Toast.makeText(this, message, Toast.LENGTH_LONG).show()
                result.success(message)
            }
        }
    }
    fun setFrequencyLevelCPU0Max(freq: String): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo $freq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU4Max(freq: String): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo $freq > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU0Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU4Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 825600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq")
        process.waitFor()
    }

    
    fun setDefaultFrequencyLevelCPU0Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1766400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU4Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 2649600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU0Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU4Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 825600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq")
        process.waitFor()
    }
}
