import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../util/constants/colors.dart';
import '../../controllers/report/report_controller.dart';

class DashboardCasesRows extends DataTableSource {
  final ReportController _reportController = Get.find<ReportController>();

  DashboardCasesRows() {
    // Update table when data changes
    ever(_reportController.reports, (_) {
      notifyListeners(); // ✅ Refresh table when data updates
    });
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _reportController.reports.length) return null; // Prevent index errors

    final report = _reportController.reports[index];

    return DataRow2(
      cells: [
        DataCell(
          SelectableText(
            report.id ?? 'N/A',
            style: TextStyle(color: TColors.accent, fontWeight: FontWeight.bold),
          ),
        ),
        DataCell(Text(report.cropType, style: TextStyle(fontWeight: FontWeight.w500))),
        DataCell(SelectableText(report.phoneNumber)),
        DataCell(Text(DateFormat('dd MMM, yyyy').format(report.date))),
        DataCell(Text(report.city)),
        DataCell(Text(report.district)),
        DataCell(Text(report.ward)),
        DataCell(
          Tooltip(
            message: report.predictionResult.join(', '),
            child: Text(
              report.predictionResult.join(', '),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _reportController.reports.length;

  @override
  int get selectedRowCount => 0;
}
