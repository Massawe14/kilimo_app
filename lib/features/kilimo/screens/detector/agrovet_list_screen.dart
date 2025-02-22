import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/officer/agrovet_controller.dart';
import '../../models/agrovet/agrovet_model.dart';

class AgrovetListScreen extends StatelessWidget {
  const AgrovetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agrovetController = Get.put(AgrovetController());
    // Fetch Agrovet data based on the user's ward
    agrovetController.fetchAgrovetsByWard();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Agrovet List", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (agrovetController.agrovetList.isEmpty) {
            return const Center(
              child: Text("No Agrovets found in your ward"),
            );
          }

          return ListView.builder(
            shrinkWrap: true, // Fixes the infinite height issue
            physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling
            itemCount: agrovetController.agrovetList.length,
            itemBuilder: (context, index) {
              final AgrovetModel agrovet = agrovetController.agrovetList[index];

              return TRoundedContainer(
                child: ListTile(
                  title: Text(
                    agrovet.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("📞 Phone:"),
                          Text(agrovet.phoneNumber),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🌍 Country:"),
                          Text(agrovet.country),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🏞️ State:"),
                          Text(agrovet.state),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🏙️ City:"),
                          Text(agrovet.city),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("📍 District:"),
                          Text(agrovet.district),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("🗺️ Ward:"),
                          Text(agrovet.ward),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
