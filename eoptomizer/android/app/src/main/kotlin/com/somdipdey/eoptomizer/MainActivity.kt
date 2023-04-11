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
import android.os.SystemClock



class MainActivity: FlutterActivity() {


    private val OPTIMIZATION_CHANNEL = "com.somdipdey.eoptomizer/frequency"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, OPTIMIZATION_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "setFrequencyLevelCPU0Max" || call.method == "setFrequencyLevelCPU4Max" || call.method == "setFrequencyLevelCPU0Min" || call.method == "setFrequencyLevelCPU4Min" || call.method == "setFrequencyLevelGPU") {
                var arguments = call.arguments() as Map<String,String>?
                var LITTLECPUMaxFreq = arguments?.get("LITTLECPUMaxFreq")?.toString() ?: "1794000"
                val bigCPUMaxFreq = arguments?.get("bigCPUMaxFreq")?.toString() ?: "1794000"
                val GPUFreq = arguments?.get("GPUFreq")?.toString() ?: "572000"
                setFrequencyLevelCPU0Max(LITTLECPUMaxFreq)
                setFrequencyLevelCPU4Max(bigCPUMaxFreq)
                setFrequencyLevelGPU(GPUFreq)
                setFrequencyLevelCPU0Min()
                setFrequencyLevelCPU4Min()
                setSignalFile("1")
                val message = "Optimizing frequencies on CPU0 - $LITTLECPUMaxFreq, CPU4 - $bigCPUMaxFreq, GPU - $GPUFreq"
                Toast.makeText(this, message, Toast.LENGTH_LONG).show()
                result.success(message)
            }

            if (call.method == "setDefaultFrequencyLevelCPU0Max" || call.method == "setDefaultFrequencyLevelCPU4Max" || call.method == "setDefaultFrequencyLevelCPU0Min" || call.method == "setDefaultFrequencyLevelCPU4Min" || call.method == "setDefaultFrequencyLevelGPU") {
                setDefaultFrequencyLevelCPU0Max()
                setDefaultFrequencyLevelCPU4Max()
                setDefaultFrequencyLevelCPU0Min()
                setDefaultFrequencyLevelCPU4Min()
                setDefaultFrequencyLevelGPU()
                setSignalFile("0")
                val message = "Setting default frequencies on CPU0, CPU4, GPU"
                Toast.makeText(this, message, Toast.LENGTH_LONG).show()
                result.success(message)
            }

            if (call.method == "getFPS") {
                val FPS = getFrameRate()
                result.success(FPS)
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
    fun setFrequencyLevelGPU(freq: String): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo $freq > /sys/kernel/gpu/gpu_max_clock")
        process.waitFor()
    }
    fun setFrequencyLevelCPU0Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 455000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setFrequencyLevelCPU4Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 650000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq")
        process.waitFor()
    }

    
    fun setDefaultFrequencyLevelCPU0Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1794000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU4Max(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 1794000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU0Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 455000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelCPU4Min(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 650000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq")
        process.waitFor()
    }
    fun setDefaultFrequencyLevelGPU(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo 572000 > /sys/kernel/gpu/gpu_max_clock")
        process.waitFor()
    }

    fun executeProfiling(): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c nohup ./data/local/tmp/profiling.sh &")
        process.waitFor()
    }
    fun setSignalFile(signal: String): Unit {
        val process: java.lang.Process = java.lang.Runtime.getRuntime().exec("su -c echo $signal > /data/local/tmp/signal.txt")
        process.waitFor()
    }
    fun getFrameRate(): String {
        val timeElapsed1 = SystemClock.elapsedRealtime()
        val timeElapsed2 = SystemClock.elapsedRealtime()
        val frameTime = 1000.0 / (timeElapsed2 - timeElapsed1)
        return frameTime.toString()
    }
    fun getFrequencyLevelLITTLECPU(): String? {
        var result: String? = null
        try {
            java.lang.Runtime.getRuntime().exec("su -c cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq").getInputStream().use { inputStream -> java.util.Scanner(inputStream).useDelimiter("\\A").use { s -> result = if (s.hasNext()) s.next() else null } }
        } catch (e: java.io.IOException) {
            e.printStackTrace()
        }
        return result
    }
}
