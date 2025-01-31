import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

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
        DataColumn2(label: Text('Report ID')),
        DataColumn2(label: Text('Crop Type')),
        DataColumn2(label: Text('Phone Number')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('City')),
        DataColumn2(label: Text('District')),
        DataColumn2(label: Text('Ward')),
        DataColumn2(label: Text('Prediction Results')),
      ],
      source: DashboardCasesRows(),
    );
  }
}
