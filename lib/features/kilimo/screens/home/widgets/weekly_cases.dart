import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../controllers/report/report_controller.dart';

class TWeeklyCasesGraph extends StatelessWidget {
  const TWeeklyCasesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final reportController = Get.find<ReportController>();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('weekly_cases'.tr, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),

          SizedBox(
            height: 400,
            child: Obx(() {
              final weeklyData = reportController.weeklyCases;

              return BarChart(
                BarChartData(
                  titlesData: buildFlTitlesData(),
                  borderData: FlBorderData(show: true, border: const Border(top: BorderSide.none, right: BorderSide.none)),
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                  ),
                  barGroups: List.generate(7, (index) {
                    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (weeklyData[days[index]] ?? 0).toDouble(),
                          color: Colors.blue,
                        ),
                      ],
                    );
                  }),
                  groupsSpace: TSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => TColors.secondary),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          final index = value.toInt() % days.length;
          return SideTitleWidget(
            space: 4,
            meta: meta,
            child: Text(days[index], style: const TextStyle(fontSize: 12)),
          );
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: true, interval: 2, reservedSize: 50),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
