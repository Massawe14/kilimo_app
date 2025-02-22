import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/report/report_controller.dart';

class ReportScreen extends StatelessWidget {
  final ReportController reportController = Get.put(ReportController());

  ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reports".tr),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.notification,
            ),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              // Show the popup menu when the icon is clicked
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("crop_disease_report".tr, style: Theme.of(context).textTheme.headlineMedium, overflow: TextOverflow.ellipsis),
                IconButton(
                  icon: Icon(Iconsax.document_download5, size: 30, color: TColors.primary),
                  onPressed: () => _exportToPDF(),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Expanded(
              child: TRoundedContainer(
                child: TPaginatedDataTable(
                  minWidth: 700,
                  tableHeight: 500,
                  dataRowHeight: TSizes.xl * 1.2,
                  columns: [
                    DataColumn2(label: Text('ID')),
                    DataColumn2(label: Text('crop_type'.tr)),
                    DataColumn2(label: Text('phone_number'.tr)),
                    DataColumn2(label: Text('date'.tr)),
                    DataColumn2(label: Text('city'.tr)),
                    DataColumn2(label: Text('district'.tr)),
                    DataColumn2(label: Text('ward'.tr)),
                    DataColumn2(label: Text('prediction'.tr)),
                    // DataColumn2(label: Text('Actions')),
                  ],
                  source: ReportDataTableSource(reportController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to export data to PDF
  void _exportToPDF() async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Crop Disease Report", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(2),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(2),
                  5: pw.FlexColumnWidth(2),
                  6: pw.FlexColumnWidth(3),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("Crop Type", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("Phone", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("Date", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("City", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("District", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("Ward", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                      pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text("Prediction", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    ],
                  ),
                  // Table Data
                  ...reportController.reports.map((report) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.cropType)),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.phoneNumber)),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(DateFormat('yyyy-MM-dd').format(report.date))),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.city)),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.district)),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.ward)),
                        pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(report.predictionResult.join(', '))),
                      ],
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}

// Custom DataTable Source
class ReportDataTableSource extends DataTableSource {
  final ReportController reportController;

  ReportDataTableSource(this.reportController);

  @override
  DataRow? getRow(int index) {
    if (index >= reportController.reports.length) return null;

    final report = reportController.reports[index];

    return DataRow2(
      cells: [
        DataCell(Text(report.id ?? 'N/A')),
        DataCell(Text(report.cropType)),
        DataCell(Text(report.phoneNumber)),
        DataCell(Text(DateFormat('yyyy-MM-dd').format(report.date))),
        DataCell(Text(report.city)),
        DataCell(Text(report.district)),
        DataCell(Text(report.ward)),
        DataCell(Text(report.predictionResult.join(', '))),
        // DataCell(
        //   IconButton(
        //     icon: Icon(Icons.delete, color: Colors.red),
        //     onPressed: () => _deleteReport(report.id),
        //   ),
        // ),
      ],
    );
  }

  // void _deleteReport(String? id) {
  //   if (id == null) return;

  //   Get.defaultDialog(
  //     title: "Delete Report",
  //     middleText: "Are you sure you want to delete this report?",
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         reportController.reports.removeWhere((r) => r.id == id);
  //         notifyListeners();
  //         Get.back();
  //       },
  //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //       child: Text("Delete"),
  //     ),
  //     cancel: TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
  //   );
  // }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => reportController.reports.length;

  @override
  int get selectedRowCount => 0;
}
