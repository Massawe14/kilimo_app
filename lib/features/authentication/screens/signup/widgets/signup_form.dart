import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../util/constants/sizes.dart';
import '../../../../../util/constants/text_strings.dart';
import '../../../../../util/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';
import 'terms_and_condtion_checkbox.dart';

class TSignupForm extends StatelessWidget {
  TSignupForm({
    super.key,
  });

  final List<String> roleItems = [
    'Farmer', 
    'Extension Officer',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                  validator: (value) => TValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: TTexts.firstname,
                    hintText: 'Enter your first name',
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastname,
                  validator: (value) => TValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: TTexts.lastname,
                    hintText: 'Enter your last name',
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Username
          TextFormField(
            controller: controller.username,
            validator: (value) => TValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.username,
              hintText: 'Enter your username',
              prefixIcon: const Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.email,
              hintText: 'Enter your email',
              prefixIcon: const Icon(Iconsax.direct),
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
              hintText: 'Enter your phone number',
              prefixIcon: const Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Role Selection
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => DropdownButtonFormField2<String>(
                    onChanged: (value) {
                      controller.selectedRole.value = value ?? '';
                    },
                    validator: (value) => controller.selectedRole.value.isEmpty ? 'Please select a role' : null,
                    decoration: InputDecoration(
                      labelText: TTexts.role,
                      prefixIcon: const Icon(Iconsax.user_tag),
                    ),
                    isExpanded: true,
                    items: roleItems
                      .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                    value: controller.selectedRole.value.isEmpty ? null : controller.selectedRole.value,
                  ),
                ),
              ),
            ],
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
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            // Labels for dropdown
            countryDropdownLabel: "Select Country",
            stateDropdownLabel: "Select State",
            cityDropdownLabel: "Select City",
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
                    hintText: 'Enter district',
                    prefixIcon: const Icon(Iconsax.location),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.street,
                  validator: (value) => TValidator.validateEmptyText('Street', value),
                  decoration: InputDecoration(
                    labelText: TTexts.street,
                    hintText: 'Enter street',
                    prefixIcon: const Icon(Iconsax.location),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ]
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password,
                hintText: 'Enter your password',
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, 
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Terms & Conditions Checkbox
          const TTermsAndConditonCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
