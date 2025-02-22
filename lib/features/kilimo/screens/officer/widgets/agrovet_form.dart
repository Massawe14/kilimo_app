import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/validators/validation.dart';
import '../../../controllers/officer/agrovet_controller.dart';

class TAgrovetForm extends StatelessWidget {
  const TAgrovetForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgrovetController());
    
    return Form(
      key: controller.agrovetFormKey,
      child: Column(
        children: [
          // Full Name
          TextFormField(
            controller: controller.fullname,
            validator: (value) => TValidator.validateEmptyText('Full Name', value),
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.fullname,
              hintText: 'agrovet_hint'.tr,
              prefixIcon: const Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.phoneNo,
              hintText: 'enter_phone_number'.tr,
              prefixIcon: const Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Address
          CSCPickerPlus(
            layout: Layout.vertical,
            flagState: CountryFlag.ENABLE,
            onCountryChanged: (country){
              controller.selectedCountry.value = country;
            },
            onStateChanged: (state){
              controller.selectedState.value = state ?? '';
            },
            onCityChanged: (city){
              controller.selectedCity.value = city ?? '';
            },
            // Placeholders for dropdown search field
            countrySearchPlaceholder: "country".tr,
            stateSearchPlaceholder: "state".tr,
            citySearchPlaceholder: "city".tr,

            // Labels for dropdown
            countryDropdownLabel: "select_country".tr,
            stateDropdownLabel: "select_state".tr,
            cityDropdownLabel: "select_city".tr,
            dropdownDialogRadius: 12.0,
            searchBarRadius: 30.0,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.district,
                  validator: (value) => TValidator.validateEmptyText('District', value),
                  decoration: InputDecoration(
                    labelText: TTexts.district,
                    hintText: 'enter_district'.tr,
                    prefixIcon: const Icon(Iconsax.location),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.ward,
                  validator: (value) => TValidator.validateEmptyText('Ward', value),
                  decoration: InputDecoration(
                    labelText: TTexts.street,
                    hintText: 'enter_ward'.tr,
                    prefixIcon: const Icon(Iconsax.location),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ]
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.registerAgrovet(),
              child: Text(TTexts.tSave),
            ),
          ),
        ],
      ),
    );
  }
}
