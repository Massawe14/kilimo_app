import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../../../util/helpers/helper_functions.dart';
import 'widgets/cultivationTips/by_stage.dart';
import 'widgets/cultivationTips/by_task.dart';

class CultivationTipsScreen extends StatelessWidget {
  const CultivationTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.arrow_left, 
              color: darkMode ? TColors.white : TColors.black,
            ),
          ),
          title: Text('cultivation_tips'.tr),
        ),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled){
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 440,
                  // Space between AppBar and TabBar
                  automaticallyImplyLeading: false,
                  backgroundColor: darkMode ? TColors.black : TColors.white,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Heading
                                Text(
                                  'see_relavant_information_on'.tr, 
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    selectCrop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'select_crop'.tr,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      const Icon(Iconsax.arrow_down_1, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            const Row(
                              children: [
                                Text('Sowing Date 18 April, 24'),
                                SizedBox(width: 5),
                                Icon(Icons.edit),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  bottom: TTabBar(
                    tabs: [
                      Tab(child: Text('by_task'.tr)),
                      Tab(child: Text('by_stage'.tr)),
                    ],
                  ),
                ),
              ];
            }, 
            body: const TabBarView(
              children: [
                ByTask(),
                ByStage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
