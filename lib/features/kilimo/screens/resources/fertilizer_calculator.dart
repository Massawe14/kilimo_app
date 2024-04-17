import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/search_container.dart';
import '../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';

class FertilizerCalculatorScreen extends StatefulWidget {
  const FertilizerCalculatorScreen({super.key});

  @override
  FertilizerCalculatorScreenState createState() => FertilizerCalculatorScreenState();
}

class FertilizerCalculatorScreenState extends State<FertilizerCalculatorScreen> {
  String selectedCrop = "";
  String selectedUnit = "Acre";
  double plotSize = 1.0; // Default plot size
  TextEditingController nitrogenController = TextEditingController();
  TextEditingController phosphorusController = TextEditingController();
  TextEditingController potassiumController = TextEditingController();

  void calculateFertilizer() {
    // Perform calculation here
    // Save locally
    // Display output
  }

  void showNutrientQuantitiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nutrient quantities', style: Theme.of(context).textTheme.titleMedium),
          backgroundColor: Colors.white,
          content: SizedBox(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: TextFormField(
                        controller: nitrogenController,
                        decoration: const InputDecoration(labelText: 'N'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: TextFormField(
                        controller: phosphorusController,
                        decoration: const InputDecoration(labelText: 'P'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: TextFormField(
                        controller: potassiumController,
                        decoration: const InputDecoration(labelText: 'K'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Add reset logic here
                      },
                      child: const Text(
                        'Reset', 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add save logic here
                      },
                      child: const Text(
                        'Save', 
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: const Text('Fertilizer Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Heading
                  Text(
                    'See relavant information on', 
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select your crop', style: Theme.of(context).textTheme.titleMedium),
                            backgroundColor: TColors.white,
                            content: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                children: [
                                  const TSearchContainer(text: 'Search'),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: TSizes.spaceBtwSections),
                                        const TSectionHeading(title: 'Your crops', showActionButton: false),
                                        const SizedBox(height: TSizes.spaceBtwSections),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                TVerticalImageText(
                                                  image: TImages.beanCategory,
                                                  title: 'Beans',
                                                  onTap: () {},
                                                ),
                                                TVerticalImageText(
                                                  image: TImages.maizeCategory,
                                                  title: 'Maize',
                                                  onTap: () {},
                                                ),
                                                TVerticalImageText(
                                                  image: TImages.cassavaCategory,
                                                  title: 'Cassava',
                                                  onTap: () {},
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: TSizes.spaceBtwSections),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                
                                                TVerticalImageText(
                                                  image: TImages.riceCategory,
                                                  title: 'Rice',
                                                  onTap: () {},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwSections),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel', 
                                          style: TextStyle(
                                            color: TColors.info,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          selectedCrop.isNotEmpty ? selectedCrop : 'Select crop',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Nutrient quantities', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 73,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        showNutrientQuantitiesDialog(context);
                      },
                      child: const Text(
                        'N:120', 
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 73,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        showNutrientQuantitiesDialog(context);
                      },
                      child: const Text(
                        'P:60',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 75,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: () {
                        showNutrientQuantitiesDialog(context);
                      },
                      child: const Text(
                        'K:50',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  TextButton(
                    onPressed: () {
                      showNutrientQuantitiesDialog(context);
                    },
                    child: const Text(
                      'Edit', 
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Unit', showActionButton: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: "Acre",
                    groupValue: selectedUnit,
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value!;
                      });
                    },
                  ),
                  const Text('Acre'),
                  Radio(
                    value: "Hector",
                    groupValue: selectedUnit,
                    onChanged: (value) {
                      setState(() {
                        selectedUnit = value!;
                      });
                    },
                  ),
                  const Text('Hector'),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const TSectionHeading(title: 'Plot size', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sizes smaller than one unit are expressed as 0.\nExample: half acre = 0.5', 
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (plotSize > 1.0) {
                          plotSize -= 1.0;
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Plot size'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          plotSize = double.parse(value);
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        plotSize += 1.0;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    calculateFertilizer();
                  },
                  child: const Text('Calculate'),
                ),
              ),
              // Output display area
            ],
          ),
        ),
      ),
    );
  }
}
