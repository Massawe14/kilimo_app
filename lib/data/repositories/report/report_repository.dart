import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/kilimo/models/report/report_model.dart';

class ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _reports => _firestore.collection('Reports');

  // Fetch all reports as a stream
  Stream<List<Report>> getDiagnosisReports() {
    return _reports.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Report.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList());
  }

  // Fetch reports by comparing user street location
  Future<List<Report>> getReportsByLocation(String userWard) async {
    QuerySnapshot querySnapshot = await _reports.where('ward', isEqualTo: userWard).get();

    return querySnapshot.docs
        .map((doc) => Report.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();
  }

  // Delete a report
  Future<void> deleteReport(String reportId) async {
    await _reports.doc(reportId).delete();
  }
}
