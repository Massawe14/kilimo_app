import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/circular_container.dart';
import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../controllers/report/report_controller.dart';

class CasesStatusPieChart extends StatelessWidget {
  const CasesStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final reportController = Get.find<ReportController>();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('cases_by_crop_type'.tr, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Observing data changes
          Obx(() {
            final cropCases = reportController.cropDistribution;
            int totalCases = cropCases.values.fold(0, (sum, value) => sum + value);

            List<PieChartSectionData> pieSections = [];

            if (totalCases > 0) {
              cropCases.forEach((crop, count) {
                double percentage = (count / totalCases) * 100;

                pieSections.add(
                  PieChartSectionData(
                    color: _getColorForCrop(crop),
                    value: count.toDouble(),
                    title: '${percentage.toStringAsFixed(0)}%',
                    radius: 80,
                    titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              });
            } else {
              // Fallback case if there are no cases
              pieSections.add(
                PieChartSectionData(
                  color: Colors.grey,
                  value: 100,
                  title: "no_data".tr,
                  radius: 60,
                  titleStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              );
            }

            return SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: pieSections,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                      if (pieTouchResponse?.touchedSection != null) {
                        int sectionIndex = pieTouchResponse!.touchedSection!.touchedSectionIndex;
                        debugPrint("Touched section: $sectionIndex");
                      }
                    },
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Table to display data
          Obx(() {
            final cropCases = reportController.cropDistribution;
            int totalCases = cropCases.values.fold(0, (sum, value) => sum + value);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(label: Text('crop_type'.tr, style: Theme.of(context).textTheme.bodyMedium)),
                  DataColumn(label: Text('cases'.tr, style: Theme.of(context).textTheme.bodyMedium)),
                  DataColumn(label: Text('percentage'.tr, style: Theme.of(context).textTheme.bodyMedium)),
                ],
                rows: cropCases.entries.map((entry) {
                  String crop = entry.key;
                  int count = entry.value;
                  double percentage = (totalCases > 0) ? (count / totalCases) * 100 : 0;
                  Color cropColor = _getColorForCrop(crop);

                  return DataRow(cells: [
                    DataCell(
                      Row(
                        children: [
                          TCircularContainer(
                            width: 20,
                            height: 20,
                            backgroundColor: cropColor,
                          ),
                          const SizedBox(width: 8),
                          Text(crop, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    DataCell(Text(count.toString(), style: Theme.of(context).textTheme.bodyMedium)),
                    DataCell(Text('${percentage.toStringAsFixed(0)}%', style: Theme.of(context).textTheme.bodyMedium)),
                  ]);
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Helper method to assign color based on crop type
  Color _getColorForCrop(String crop) {
    switch (crop) {
      case 'Maize':
        return Colors.yellow.shade700;
      case 'Beans':
        return Colors.green.shade700;
      case 'Cassava':
        return Colors.orange.shade600;
      case 'Rice':
        return Colors.brown.shade400;
      default:
        return Colors.grey;
    }
  }
}
