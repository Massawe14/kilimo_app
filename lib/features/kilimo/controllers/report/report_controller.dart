import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../models/report/report_model.dart';

class ReportController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepository = UserRepository();

  var reports = <Report>[].obs;
  var isLoading = false.obs;

  // Stats
  var totalFarmers = 0.obs;
  var totalCases = 0.obs;
  
  // Weekly cases map
  var weeklyCases = RxMap<String, int>({
    "Mon": 0, "Tue": 0, "Wed": 0, "Thu": 0, "Fri": 0, "Sat": 0, "Sun": 0,
  });

  var recentCases = <Report>[].obs;

  // Separate observables for disease and crop distributions
  var diseaseDistribution = <String, int>{}.obs;
  var cropDistribution = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilteredReports();
  }

  /// Fetch reports where user location matches the officer's street location
  Future<void> fetchFilteredReports() async {
    try {
      isLoading(true);

      // Get current user details (Officer)
      var user = _userRepository.getCurrentUser();
      if (user == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      // Fetch officer's location
      var userDoc = await _firestore.collection('Users').doc(user.uid).get();
      if (!userDoc.exists) {
        Get.snackbar("Error", "User profile not found");
        return;
      }

      String officerStreet = userDoc['Street'] ?? '';

      // Query reports where user location matches officer location
      var snapshot = await _firestore
        .collection('Reports')
        .where('ward', isEqualTo: officerStreet) // Ensure correct Firestore field
        .get();

      var fetchedReports = snapshot.docs.map((doc) => Report.fromSnapshot(doc)).toList();
      reports.assignAll(fetchedReports);

      // Update statistics
      updateStatistics(fetchedReports);
    } catch (e) {
      Get.snackbar("Error", "Failed to load reports: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Update statistics dynamically
  void updateStatistics(List<Report> fetchedReports) {
    // Reset all stats
    totalFarmers.value = 0;
    totalCases.value = 0;
    weeklyCases.updateAll((key, value) => 0); // Reset weekly cases without flickering
    diseaseDistribution.clear();
    cropDistribution.clear();
    recentCases.clear();

    if (fetchedReports.isEmpty) return;

    // Total Farmers (Unique user count)
    totalFarmers.value = fetchedReports.map((r) => r.userId).toSet().length;

    // Total Cases
    totalCases.value = fetchedReports.length;

    // Weekly Cases Count
    processWeeklyCases(fetchedReports);

    // Recent Cases (Last 5 reports)
    recentCases.assignAll(fetchedReports.take(5));

    // Cases Distribution (Pie Chart Data)
    Map<String, int> diseaseCount = {};
    Map<String, int> cropCases = {};

    for (var report in fetchedReports) {
      // Count diseases in reports
      for (var disease in report.predictionResult) {
        diseaseCount[disease] = (diseaseCount[disease] ?? 0) + 1;
      }

      // Count cases by crop type
      cropCases[report.cropType] = (cropCases[report.cropType] ?? 0) + 1;
    }

    diseaseDistribution.assignAll(diseaseCount);
    cropDistribution.assignAll(cropCases);
  }

  /// Process Weekly Cases
  void processWeeklyCases(List<Report> fetchedReports) {
    Map<String, int> tempCases = {
      "Mon": 0, "Tue": 0, "Wed": 0, "Thu": 0, "Fri": 0, "Sat": 0, "Sun": 0,
    };

    for (var report in fetchedReports) {
      String day = DateFormat('EEE').format(report.date); // Extract "Mon", "Tue", etc.
      if (tempCases.containsKey(day)) {
        tempCases[day] = tempCases[day]! + 1;
      }
    }

    // Update existing map to avoid UI flickering
    weeklyCases.assignAll(tempCases);
  }
}
