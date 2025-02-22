import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/constants/text_strings.dart';
import '../../../../util/helpers/helper_functions.dart';
import '../../controllers/report/report_controller.dart';
import '../table/data_table.dart';
import 'widgets/cases_status_graph.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/weekly_cases.dart';

class OfficerHomeScreen extends StatelessWidget {
  const OfficerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final ReportController reportController = Get.put(ReportController());
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TTexts.appName.tr,
          style: TextStyle(
            color: darkMode ? TColors.white : TColors.black,
          ),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards
            // Dashboard Stats
            Obx(
              () => TDashboardCard(
                stats: reportController.totalFarmers.value,
                title: 'total_farmer'.tr,
                subTitle: '${reportController.totalFarmers.value} registered',
                comparisonText: "compared_to_last_week".tr,
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Obx(
              () => TDashboardCard(
                stats: reportController.totalCases.value,
                title: 'total_case'.tr,
                subTitle: '${reportController.totalCases.value} detected',
                comparisonText: "compared_to_last_7_week".tr,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Bar Graph
            const TWeeklyCasesGraph(),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Recent Cases Table
            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('recent_cases'.tr, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const DashboardCasesTable(),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Pie Chart
            const CasesStatusPieChart(),
          ],
        ),
      ),
    );
  }
}
