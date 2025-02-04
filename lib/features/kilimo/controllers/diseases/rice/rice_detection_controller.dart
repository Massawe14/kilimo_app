import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../../util/constants/api_constants.dart';
import '../../../../../util/popups/loaders.dart';
import '../../../models/report/report_model.dart';

class RiceDetectionController extends GetxController {
  var imageFile = Rx<File?>(null);
  var detectionResult = Rx<Map<String, dynamic>?>(null);
  var user = Rx<User?>(null);
  var isLoading = false.obs;

  final ImagePicker picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await detectDisease();
    }
  }

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      await detectDisease();
    }
  }

   Future<void> detectDisease() async {
    final url = Uri.parse(APIConstants.tRiceDetectionAPIURL);

    // Print request details for debugging
    debugPrint('URL: $url');
    debugPrint('File path: ${imageFile.value!.path}');

    try {
      if (imageFile.value == null) return;

      isLoading.value = true;

      final request = http.MultipartRequest('POST', url);

      request.fields.addAll({'user_id': '2'});

      request.files.add(
        await http.MultipartFile.fromPath(
          'file', 
          imageFile.value!.path,
        ),
      );

      // Log the request data
      debugPrint('Request data: ${request.files.first.filename}');

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonResponse = json.decode(responseBody);

        // Validate the response structure
        if (jsonResponse.containsKey('results') && jsonResponse['results'].containsKey('boxes') && jsonResponse['results'].containsKey('names')) {
          const JsonEncoder encoder = JsonEncoder.withIndent('  ');
          debugPrint('Response Body: ${encoder.convert(jsonResponse)}');
          detectionResult.value = jsonResponse;

          // Save report to Firestore
          await saveReport();
        } else {
          debugPrint('Invalid response structure: $jsonResponse');
          detectionResult.value = null;
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response: $responseBody');
        detectionResult.value = null;
      }
    } catch (e) {
      // Print any errors that occur during the request
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> getBoxes(double imageWidth, double imageHeight) {
    if (detectionResult.value == null) return [];
    List<dynamic> boxes = detectionResult.value!['results']['boxes']['xyxy'];
    List<dynamic> confs = detectionResult.value!['results']['boxes']['conf'];
    List<dynamic> cls = detectionResult.value!['results']['boxes']['cls'];
    Map<String, dynamic> names = detectionResult.value!['results']['names'];

    List<Map<String, dynamic>> boxList = [];
    for (int i = 0; i < boxes.length; i++) {
      int classIndex = cls[i].toInt();
      String className = names[classIndex.toString()] ?? 'Unknown';
      double confidence = confs[i];

      // Normalize coordinates
      double left = boxes[i][0] / detectionResult.value!['results']['orig_shape'][1];
      double top = boxes[i][1] / detectionResult.value!['results']['orig_shape'][0];
      double right = boxes[i][2] / detectionResult.value!['results']['orig_shape'][1];
      double bottom = boxes[i][3] / detectionResult.value!['results']['orig_shape'][0];

      boxList.add({
        'box': [left, top, right, bottom],
        'conf': confidence,
        'name': className,
      });
    }
    return boxList;
  }

  Map<String, dynamic>? getHighestConfidenceBox(List<Map<String, dynamic>> boxes) {
    if (boxes.isEmpty) return null;

    boxes.sort((a, b) => b['conf'].compareTo(a['conf']));
    return boxes.first;
  }

  // Save diagnosis report to Firestore
  Future<void> saveReport() async {
    final highestConfidenceBox = getHighestConfidenceBox(getBoxes(1, 1));

    if (highestConfidenceBox == null) return;

    if (user.value == null) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'User not authenticated',
      );
      return;
    }

    String userId = user.value!.uid;

    // Fetch user details from Firestore (assuming user details are stored in a collection 'users')
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    final report = Report(
      id: '',
      userId: userId,
      phoneNumber: userDoc['PhoneNumber'],
      cropType: "Rice",
      predictionResult: [highestConfidenceBox['name']],
      city: userDoc['City'],
      district: userDoc['District'],
      ward: userDoc['Street'],
      date: DateTime.now(),
    );

    try {
      await firestore.collection('Reports').add(report.toJson());
      debugPrint("Diagnosis report saved successfully!");

      // Send SMS notification
      await sendDetectionNotification(
        phoneNumber: userDoc['PhoneNumber'],
        cropType: "Rice",
        detectionResult: highestConfidenceBox['name'],
      );
    } catch (e) {
      debugPrint("Error saving report: $e");
    }
  }

  // Send SMS Notification
  Future<void> sendDetectionNotification({
    required String phoneNumber,
    required String cropType,
    required String detectionResult,
  }) async {
    const String api_key = APIConstants.tBEEMSMSAPIKEY;
    const String secret_key = APIConstants.tBEEMSMSSECRETEKEY;
    const String senderId = "DIGIFISH";
    const String url = APIConstants.tBEEMSMSURL;

    // Ensure phone number is in international format (Tanzania +255)
    if (phoneNumber.startsWith("0")) {
      phoneNumber = "255${phoneNumber.substring(1)}"; // Convert to 255764073294
    }

    // Construct message
    String message = "Kilimo App: Your $cropType detection result is '$detectionResult'.";

    // Encode credentials properly
    String credentials = "$api_key:$secret_key";
    String basicAuth = "Basic ${base64Encode(utf8.encode(credentials))}";

    // Set headers
    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth,
    };

    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode({
      "source_addr": senderId,
      "encoding": 0,
      "schedule_time": "",
      "message": message,
      "recipients": [
        {
          "recipient_id": "1",
          "dest_addr": phoneNumber
        }
      ]
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
      debugPrint("✅ SMS sent successfully!");
    }
    else {
      debugPrint(response.reasonPhrase);
      debugPrint("❌ Failed to send SMS. Error: ${response.statusCode}");
    }
  }

  // Clear output when the screen is closed
  void clearOutputOnClose() {
    isLoading.value = false;
    detectionResult.value!.clear();
    imageFile.value = null;
  }
}
