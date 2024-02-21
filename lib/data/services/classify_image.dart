import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TFLiteService {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/resnet_model_beans.tflite', // Replace with your actual model path
      labels: 'assets/model/labels.txt', // Replace with your actual labels path
    );
  }

  Future<Map<String, dynamic>> classifyImage(PickedFile imageFile) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: imageFile.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
      );

      return {
        'success': true,
        'result': output != null && output.isNotEmpty ? output[0]['label'] : null,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  void closeModel() {
    Tflite.close();
  }
}

