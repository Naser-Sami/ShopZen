import 'dart:developer';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final user = sl<FirebaseAuth>().currentUser;

  DateTime date = DateTime(2016, 10, 26);

  String phoneNumber = '';
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  void initState() {
    super.initState();

    nameController.text = user?.displayName ?? '';
    emailController.text = user?.email ?? '';
    _initializePhoneNumber();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Theme.of(context).cardColor,
        ),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  void _initializePhoneNumber() async {
    if (user?.phoneNumber != null && user!.phoneNumber!.isNotEmpty) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumber.getRegionInfoFromPhoneNumber(user!.phoneNumber!);
        setState(() {
          number = phoneNumber;
          phoneNumberController.text = phoneNumber.phoneNumber ?? '';
        });
      } catch (e) {
        log('Error parsing phone number: $e');
      }
    }
  }

  Future<void> _getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    setState(() {
      this.number = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name
              TextFormFieldComponent(
                title: 'Full Name',
                textFieldWithTitle: true,
                controller: nameController,
                hintText: 'Enter your full name',
                validator: (String? value) =>
                    TValidator.validateEmptyText('Full name', value),
              ),
              const SizedBox(height: TSize.s16),

              // Email Address
              TextFormFieldComponent(
                title: 'Email Address',
                textFieldWithTitle: true,
                controller: emailController,
                hintText: 'Enter your email',
                validator: TValidator.validateEmail,
              ),
              const SizedBox(height: TSize.s16),

              // Date of Birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Date of Birth',
                    style: theme.textTheme.titleMedium,
                  ),
                  TSize.s04.toHeight,
                  Container(
                    height: TSize.s52,
                    padding: EdgeInsetsDirectional.symmetric(
                            vertical: TPadding.p12, horizontal: TPadding.p20)
                        .copyWith(end: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
                      ),
                      borderRadius: BorderRadius.circular(TSize.s10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          date.formattedTimeOrDate(),
                          style: theme.textTheme.bodyLarge,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => _showDialog(
                            CupertinoDatePicker(
                              initialDateTime: date,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              // This shows day of week alongside day of month
                              showDayOfWeek: false,
                              // This is called when the user changes the date.
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() => date = newDate);
                              },
                            ),
                          ),
                          icon: const IconWidget(name: 'Calendar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s16),

              // Gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Gender',
                    style: theme.textTheme.titleMedium,
                  ),
                  TSize.s04.toHeight,
                  Container(
                    height: TSize.s52,
                    padding: EdgeInsets.symmetric(
                        vertical: TPadding.p12, horizontal: TPadding.p20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
                      ),
                      borderRadius: BorderRadius.circular(TSize.s10),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(TSize.s10),
                      style: theme.textTheme.bodyLarge,
                      icon: RotatedBox(
                        quarterTurns: 3,
                        child: const Icon(Icons.arrow_back_ios_new_sharp),
                      ),
                      value: 'Male',
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Male',
                          child: TextWidget('Male'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Female',
                          child: TextWidget('Female'),
                        ),
                      ],
                      onChanged: (String? value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s16),

              // Phone Number
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Phone Number',
                    style: theme.textTheme.titleMedium,
                  ),
                  TSize.s04.toHeight,
                  Container(
                    height: TSize.s55,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: TPadding.p20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
                      ),
                      borderRadius: BorderRadius.circular(TSize.s10),
                    ),
                    child: InternationalPhoneNumberInput(
                      scrollPadding: EdgeInsets.all(20),
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle: theme.textTheme.bodyLarge,
                        contentPadding: EdgeInsets.only(bottom: 12),
                      ),
                      autoFocusSearch: true,
                      selectorButtonOnErrorPadding: 0,
                      searchBoxDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(TSize.s10),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.40),
                          ),
                        ),
                      ),
                      onInputChanged: (PhoneNumber number) {
                        phoneNumber = number.phoneNumber.toString();
                      },
                      onFieldSubmitted: (value) {},
                      onInputValidated: (bool value) {
                        if (!value) {
                          log("Invalid phone number: $phoneNumber");
                          // ToastNotification.showErrorNotification(context,
                          //     message: 'Invalid phone number');
                        } else {
                          log("Valid phone number: $phoneNumber");
                          // ToastNotification.showSuccessNotification(context,
                          //     message: 'Valid phone number');
                        }
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                      ),
                      ignoreBlank: true,
                      spaceBetweenSelectorAndTextField: 0,
                      autoValidateMode: AutovalidateMode.disabled,
                      initialValue: number,
                      textFieldController: phoneNumberController,
                      formatInput: true,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSize.s48),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _getPhoneNumber(phoneNumber);
                    _formKey.currentState?.save();
                  } else {}
                },
                child: const TextWidget('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
