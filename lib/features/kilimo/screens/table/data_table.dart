import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../util/constants/sizes.dart';
import 'table_source.dart';

class DashboardCasesTable extends StatelessWidget {
  const DashboardCasesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: TSizes.xl * 1.2,
      columns: [
        DataColumn2(label: Text('case_id'.tr)),
        DataColumn2(label: Text('crop_type'.tr)),
        DataColumn2(label: Text('phone_number'.tr)),
        DataColumn2(label: Text('date'.tr)),
        DataColumn2(label: Text('city'.tr)),
        DataColumn2(label: Text('district'.tr)),
        DataColumn2(label: Text('ward'.tr)),
        DataColumn2(label: Text('results'.tr)),
      ],
      source: DashboardCasesRows(),
    );
  }
}
