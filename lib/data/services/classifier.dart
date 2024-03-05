import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import '../models/classifier_category.dart';
import '../models/classifier_model.dart';

class Classifier {
  final ClassifierModel _model;
  final List<String> _labels;

  Classifier._({required List<String> labels, required ClassifierModel model})
    : _labels = labels,
      _model = model;

  static Future<Classifier> loadWith({required String modelFileName, required String labelsFileName}) async {
    final model = await _loadModel(modelFileName);
    final labels = await _loadLabels(labelsFileName);

    return Classifier._(labels: labels, model: model);
  }
  
  // Loading Classification Labels
  static Future<List<String>> _loadLabels(String labelsFileName) async {
    // #1
    final rawLabels = await FileUtil.loadLabels(labelsFileName);

    // #2
    final labels = rawLabels
      .map((label) => label.substring(label.indexOf(' ')).trim())
      .toList();

    debugPrint('Labels: $labels');
    return labels;
  }
  
  // Loading Classification Model
  static Future<ClassifierModel> _loadModel(String modelFileName) async {
    final interpreter = await Interpreter.fromAsset(modelFileName);

    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;

    debugPrint('Input shape: $inputShape');
    debugPrint('Output shape: $outputShape');

    final inputType = interpreter.getInputTensor(0).type;
    final outputType = interpreter.getOutputTensor(0).type;

    debugPrint('Input type: $inputType');
    debugPrint('Output type: $outputType');

    return ClassifierModel(
      interpreter: interpreter,
      inputShape: inputShape,
      outputShape: outputShape,
      inputType: inputType,
      outputType: outputType,
    );
  }
  
  // Pre-Processing Image Data
  TensorImage _preProcessInput(image) {
    final inputTensor = TensorImage(_model.inputType);
    inputTensor.loadImage(image);

    final minLength = min(inputTensor.height, inputTensor.width);
    final cropOp = ResizeWithCropOrPadOp(minLength, minLength);

    final shapeLength = _model.inputShape[1];
    final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.BILINEAR);

    final normalizeOp = NormalizeOp(127.5, 127.5);

    final imageProcessor = ImageProcessorBuilder()
        .add(cropOp)
        .add(resizeOp)
        .add(normalizeOp)
        .build();

    imageProcessor.process(inputTensor);

    return inputTensor;
  }
  
  // Post-Processing the Output Result
  List<ClassifierCategory> _postProcessOutput(TensorBuffer outputBuffer) {
    final probabilityProcessor = TensorProcessorBuilder().build();

    probabilityProcessor.process(outputBuffer);

    final labelledResult = TensorLabel.fromList(_labels, outputBuffer);

    final categoryList = <ClassifierCategory>[];

    labelledResult.getMapWithFloatValue().forEach((key, value) {
      final category = ClassifierCategory(key, value);
      categoryList.add(category);
      debugPrint('label: ${category.label}, score: ${category.score}');
    });

    categoryList.sort((a, b) => (b.score > a.score ? 1 : -1));

    return categoryList;
  }
  
  // Running the Prediction
  ClassifierCategory predict(Image image) {
    // Load the image and convert it to TensorImage for TensorFlow Input
    final inputImage = _preProcessInput(image);

    debugPrint(
      'Pre-processed image: ${inputImage.width}x${inputImage.height}, '
      'size: ${inputImage.buffer.lengthInBytes} bytes',
    );
    
    // Define the output buffer
    final outputBuffer = TensorBuffer.createFixedSize(
      _model.outputShape,
      _model.outputType,
    );
    
    // Run inference
    _model.interpreter.run(inputImage.buffer, outputBuffer.buffer);
    debugPrint('OutputBuffer: ${outputBuffer.getDoubleList()}');
    
    // Post-process the outputBuffer
    final resultCategories = _postProcessOutput(outputBuffer);
    final topResult = resultCategories.first;

    debugPrint('Top category: $topResult');

    return topResult;
  }
}
