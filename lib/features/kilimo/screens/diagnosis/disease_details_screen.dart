import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/diseases/disease_details_controller.dart';
import '../../models/disease.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  const DiseaseDetailsScreen({
    super.key, 
    required this.diseaseName,
  });

  final String diseaseName;

  @override
  Widget build(BuildContext context) {
    final DiseaseDetailsController controller = Get.put(DiseaseDetailsController(diseaseName: diseaseName)); // Instantiate with diseaseName

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Details'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.diseases.isEmpty) {
            return const Center(child: Text('Disease data not found'));
          } else {
            final disease = controller.diseases.first;
            debugPrint('$disease');
            return _buildBody(disease);
          }
        }
      ),
    );
  }

  Widget _buildBody(Disease disease) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Disease Name: ${disease.name}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildInfoList('Symptoms', disease.symptoms),
          const SizedBox(height: 20),
          _buildInfoList('Causes', disease.causes),
          const SizedBox(height: 20),
          _buildInfoList('Treatment', disease.treatment),
        ],
      ),
    );
  }

  Widget _buildInfoList(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => Text(item)).toList(),
        ),
      ],
    );
  }
}

