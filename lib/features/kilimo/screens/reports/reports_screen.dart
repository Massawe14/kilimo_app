import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/data_table/table_header.dart';
import '../../../../util/constants/sizes.dart';
import 'widgets/reports_table.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Reports', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(heading: 'Reports', breadcrumbItems: ['Reports']),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(buttonText: 'Export', onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    const ReportsTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
