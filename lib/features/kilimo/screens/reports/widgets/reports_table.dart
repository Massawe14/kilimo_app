import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/data_table/paginated_data_table.dart';
import 'table_source.dart';

class ReportsTable extends StatelessWidget {
  const ReportsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 1000,
      columns: [
        const DataColumn2(label: Text('Farmer ID')),
        const DataColumn2(label: Text('Full Name')),
        const DataColumn2(label: Text('Location')),
        const DataColumn2(label: Text('Crop Type')),
        const DataColumn2(label: Text('Crop Image')),
        const DataColumn2(label: Text('Detected Disease')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ReportsRows(),
    );
  }
}