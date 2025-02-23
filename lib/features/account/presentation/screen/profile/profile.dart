import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shop_zen/config/_config.dart';

import '/core/_core.dart';
import '/features/_features.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final UserCubit _userCubit;
  Gender _gender = Gender.undefine;
  DateTime? _selectedDate;
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US');

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _initializeUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _initializeUserData() async {
    final currentUser = _userCubit.state;
    if (currentUser != null) {
      _updateControllers(currentUser);
    }

    _userCubit.stream.listen((user) {
      if (user != null && mounted) {
        _updateControllers(user);
      }
    });

    await _initializePhoneNumber();
  }

  void _updateControllers(UserModel user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _gender = user.gender == 'male'
        ? Gender.male
        : user.gender == 'female'
            ? Gender.female
            : Gender.undefine;
    _selectedDate = DateTime.tryParse(user.dateOfBirth ?? "");
  }

  Future<void> _initializePhoneNumber() async {
    final phone = _userCubit.state?.phone;
    if (phone?.isNotEmpty ?? false) {
      try {
        final number = await PhoneNumber.getRegionInfoFromPhoneNumber(phone!);
        if (mounted) setState(() => _phoneNumber = number);
      } catch (e) {
        log('Phone number parse error: $e');
      }
    }
  }

  Future<void> _handleFormSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final user = _auth.currentUser;
    final newEmail = _emailController.text.trim();
    final currentEmail = user?.email ?? '';

    try {
      if (newEmail != currentEmail && user != null) {
        // Reauthenticate before updating the email
        await _reauthenticateUser(user);

        // ✅ Update email in Firebase Authentication (Immediate Update)
        await user.updateEmail(newEmail);

        // (Optional) Send verification email
        await user.sendEmailVerification();
      }

      // ✅ Update Firestore Collection
      final userId = _userCubit.state!.uid;
      final userData = _createUserUpdateData();
      final result = await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/$userId',
        userData,
      );

      result.handle(
        onSuccess: (_) => _handleSuccess(userId),
        onError: (error) => _handleError(error),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  Future<void> _reauthenticateUser(User user) async {
    // Show dialog to get password
    final password = await showDialog<String>(
      context: context,
      builder: (context) => _ReAuthenticationDialog(),
    );

    if (password == null || password.isEmpty) {
      throw 'ReAuthentication canceled';
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message = 'Email update failed';
    switch (e.code) {
      case 'requires-recent-login':
        message = 'Please reauthenticate to update your email';
        break;
      case 'email-already-in-use':
        message = 'Email already in use';
        break;
      case 'invalid-email':
        message = 'Invalid email address';
        break;
    }
    _handleError(message);
  }

  Map<String, dynamic> _createUserUpdateData() {
    final date = _selectedDate?.toIso8601String();
    return UserModel(
            uid: _userCubit.state!.uid,
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            createdAt: _userCubit.state?.createdAt ?? DateTime.now(),
            dateOfBirth: date ?? '',
            gender: _gender.name,
            phone: _phoneNumber.phoneNumber ?? '',
            token: _userCubit.state?.token ?? '',
            fcmToken: _userCubit.state?.fcmToken ?? '',
            profilePic: _userCubit.state?.profilePic ?? '',
            address: '',
            userType: UserType.user)
        .toMap();
  }

  void _handleSuccess(String userId) {
    ToastNotification.showSuccessNotification(context, message: 'Profile updated');
    _userCubit.getCurrentUserData(userId);
    if (mounted) context.pop();
  }

  void _handleError(String error) {
    ToastNotification.showErrorNotification(context, message: error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _ProfileAppBar(),
      body: _ProfileForm(
        formKey: _formKey,
        nameController: _nameController,
        emailController: _emailController,
        phoneNumber: _phoneNumber,
        gender: _gender,
        selectedDate: _selectedDate,
        onDateChanged: (date) => setState(() => _selectedDate = date),
        onGenderChanged: (gender) => setState(() => _gender = gender),
        onPhoneChanged: (number) => _phoneNumber = number,
        onSubmit: _handleFormSubmit,
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Profile'),
      actions: const [NotificationsIconWidget()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final PhoneNumber phoneNumber;
  final Gender gender;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<Gender> onGenderChanged;
  final ValueChanged<PhoneNumber> onPhoneChanged;
  final VoidCallback onSubmit;

  const _ProfileForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneNumber,
    required this.gender,
    required this.selectedDate,
    required this.onDateChanged,
    required this.onGenderChanged,
    required this.onPhoneChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TPadding.p20),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            _FormFieldSection(
              title: 'Full Name',
              child: TextFormFieldComponent(
                controller: nameController,
                hintText: 'Enter your full name',
                validator: (v) => TValidator.validateEmptyText('Full name', v),
              ),
            ),
            const SizedBox(height: TSize.s16),
            _FormFieldSection(
              title: 'Email Address',
              child: TextFormFieldComponent(
                controller: emailController,
                hintText: 'Enter your email',
                validator: TValidator.validateEmail,
              ),
            ),
            const SizedBox(height: TSize.s16),
            _DatePickerField(
              selectedDate: selectedDate,
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: TSize.s16),
            _GenderSelector(
              gender: gender,
              onGenderChanged: onGenderChanged,
            ),
            const SizedBox(height: TSize.s16),
            _PhoneNumberField(
              initialNumber: phoneNumber,
              onPhoneChanged: onPhoneChanged,
            ),
            const SizedBox(height: TSize.s48),
            ElevatedButton(onPressed: onSubmit, child: const TextWidget('Save')),
          ],
        ),
      ),
    );
  }
}

class _FormFieldSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormFieldSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title, style: context.textTheme.titleMedium),
        const SizedBox(height: TSize.s04),
        child,
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const _DatePickerField({
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => _DatePickerDialog(
        initialDate: selectedDate,
        onDateChanged: onDateChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _FormFieldSection(
      title: 'Date of Birth',
      child: GestureDetector(
        onTap: () => _showDatePicker(context),
        child: Container(
          height: TSize.s52,
          padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
            ),
            borderRadius: BorderRadius.circular(TSize.s10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                selectedDate?.formattedTimeOrDate() ?? "Select Date",
                style: context.textTheme.bodyLarge,
              ),
              const IconWidget(name: 'Calendar'),
            ],
          ),
        ),
      ),
    );
  }
}

class _DatePickerDialog extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const _DatePickerDialog({
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).cardColor,
      ),
      child: SafeArea(
        top: false,
        child: CupertinoDatePicker(
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          onDateTimeChanged: onDateChanged,
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onGenderChanged;

  const _GenderSelector({
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _FormFieldSection(
      title: 'Gender',
      child: Container(
        height: TSize.s52,
        padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
          ),
          borderRadius: BorderRadius.circular(TSize.s10),
        ),
        child: DropdownButton<Gender>(
          isExpanded: true,
          value: gender,
          underline: SizedBox(),
          borderRadius: BorderRadius.circular(TSize.s10),
          dropdownColor: context.theme.cardColor,
          items: Gender.values
              .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: TextWidget(gender.name.capitalize()),
                  ))
              .toList(),
          onChanged: (gender) => onGenderChanged(gender ?? Gender.male),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  final PhoneNumber initialNumber;
  final ValueChanged<PhoneNumber> onPhoneChanged;

  const _PhoneNumberField({
    required this.initialNumber,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _FormFieldSection(
      title: 'Phone Number',
      child: Container(
        height: TSize.s55,
        padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.40),
          ),
          borderRadius: BorderRadius.circular(TSize.s10),
        ),
        child: InternationalPhoneNumberInput(
          initialValue: initialNumber,
          onInputChanged: onPhoneChanged,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Phone Number',
            contentPadding: EdgeInsets.only(bottom: 12),
          ),
        ),
      ),
    );
  }
}

class _ReAuthenticationDialog extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Security Check'),
      content: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(labelText: 'Enter your password'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _passwordController.text),
          child: Text('Confirm', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
