package com.example.kilimo_app

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.Interpreter
import org.tensorflow.lite.flex.FlexDelegate
import java.nio.MappedByteBuffer
import java.nio.channels.FileChannel
import java.io.FileInputStream
import android.content.res.AssetFileDescriptor
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.kilimo_app/tensorflow"
    private lateinit var interpreter: Interpreter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
            MethodChannel(binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                when (call.method) {
                    "loadModelWithFlexDelegate" -> {
                        loadModel(result)
                    }
                    "predict" -> {
                        val inputData = call.argument<List<List<List<Float>>>>("input") // Assuming input is passed as a nested list
                        predict(inputData, result)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun loadModel(result: MethodChannel.Result) {
        try {
            val model = loadModelFile("models/lstm_150_crop_model.tflite")
            val options = Interpreter.Options()
            val flexDelegate = FlexDelegate()
            options.addDelegate(flexDelegate)

            interpreter = Interpreter(model, options)
            result.success("Model loaded with FlexDelegate")
        } catch (e: Exception) {
            result.error("ERROR", "Failed to load model: ${e.message}", null)
        }
    }

    private fun predict(input: List<List<List<Float>>>?, result: MethodChannel.Result) {
        try {
            if (input != null) {
                // Debug print the received input
                println("Received input for prediction: $input")

                // Convert the List<List<List<Float>>> to a native 3D float array
                val floatInputArray = Array(input.size) { i ->
                    Array(input[i].size) { j ->
                        FloatArray(input[i][j].size) { k ->
                            input[i][j][k]
                        }
                    }
                }

                // Output array for the prediction
                val output = Array(1) { FloatArray(46) } // Assuming 46 output classes

                // Run the model with the converted float array input
                interpreter.run(floatInputArray, output)

                // Return the prediction result to Flutter
                result.success(output[0].toList()) // Convert the output array to a list
            } else {
                result.error("ERROR", "Input data is null", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Prediction failed: ${e.message}", null)
        }
    }

    @Throws(IOException::class)
    private fun loadModelFile(modelPath: String): MappedByteBuffer {
        val fileDescriptor: AssetFileDescriptor = assets.openFd(modelPath)
        val inputStream = FileInputStream(fileDescriptor.fileDescriptor)
        val fileChannel = inputStream.channel
        val startOffset = fileDescriptor.startOffset
        val declaredLength = fileDescriptor.declaredLength
        return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength)
    }
}
