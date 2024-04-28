import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/select_crop/select_crop.dart';
import '../../../../common/widgets/texts/section_heading.dart';
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
  bool isCalculateButtonEnabled = false;

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
                      child: TextField(
                        controller: nitrogenController,
                        decoration: const InputDecoration(labelText: 'N'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: TextField(
                        controller: phosphorusController,
                        decoration: const InputDecoration(labelText: 'P'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: TextField(
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
                        Navigator.of(context).pop();
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

  void _selectUnit(value) {
    if (selectedUnit != 'Acre') {
      setState(() {
        selectedUnit = value;
      });
    } else {
      setState(() {
        selectedUnit = value;
      });
    }
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      selectCrop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          selectedCrop.isNotEmpty ? selectedCrop : 'Select crop',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const Icon(Iconsax.arrow_down_1, size: 16),
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
                    onChanged: (value) => _selectUnit(value),
                  ),
                  const Text('Acre'),
                  Radio(
                    value: "Hector",
                    groupValue: selectedUnit,
                    onChanged: (value) => _selectUnit(value),
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.minus),
                    onPressed: () {
                      setState(() {
                        if (plotSize > 1.0) {
                          plotSize -= 1.0;
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: selectedUnit),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          plotSize = double.tryParse(value) ?? 0.0;
                          if (value.isNotEmpty) {
                            isCalculateButtonEnabled = true;
                          } else {
                            isCalculateButtonEnabled = false;
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Iconsax.add),
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
                  onPressed: isCalculateButtonEnabled ? () => calculateFertilizer() : null,
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
