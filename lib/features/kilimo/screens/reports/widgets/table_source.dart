import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/data_table/table_action_icon_button.dart';
import '../../../../../common/widgets/images/t_rounded_image_2.dart';
import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/enums.dart';
import '../../../../../util/constants/image_strings.dart';
import '../../../../../util/constants/sizes.dart';

class ReportsRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(Text('123456')),
        const DataCell(Text('John Doe')),
        const DataCell(Text('Nairobi')),
        const DataCell(Text('Maize')),
        const DataCell(
          TRoundedImage2(
            width: 50,
            height: 50,
            padding: TSizes.sm,
            image: TImages.cropImage1,
            imageType: ImageType.asset,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
        ),
        const DataCell(Text('Disease')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            onEditPressed: () {},
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
