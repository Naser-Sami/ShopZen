import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class SignUpWithEmailScreen extends StatefulWidget {
  static const routeName = '/sign-up-with-email';
  const SignUpWithEmailScreen({super.key});

  @override
  State<SignUpWithEmailScreen> createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final signUpService = sl<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool enableButton = false;
  bool agreeToTerms = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void onSignUp() {
    if (_formKey.currentState!.validate()) {
      signUpService.signUpWithEmail(
        context,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  void onFieldChanged(String? v) {
    if (agreeToTerms && (v == null || v.isEmpty)) {
      enableButton = false;
    } else {
      enableButton = true;
    }

    setState(() {});
  }

  bool isEmailValid() {
    setState(() {});
    return TValidator.validateEmail(emailController.text.trim()) == null;
  }

  void onCheckBoxChanged(bool? v) {
    setState(() {
      agreeToTerms = v ?? false;
    });
  }

  void onShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void onShowConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Color borderSuccessColor = TFunctions.isDarkMode(context)
        ? DarkThemeColors.success
        : LightThemeColors.success;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: TSize.s100,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: TextWidget(
          'Login with Email',
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldComponent(
                    title: 'Email',
                    textFieldWithTitle: true,
                    controller: emailController,
                    hintText: 'Enter your email',
                    validator: TValidator.validateEmail,
                    suffixIcon: emailController.text.isNotEmpty
                        ? isEmailValid()
                            ? Icon(
                                Icons.check_circle_outline_outlined,
                                color: borderSuccessColor,
                              )
                            : const Icon(Icons.info_outline)
                        : null,
                    onChanged: onFieldChanged,
                    successColor: isEmailValid() ? borderSuccessColor : null,
                  ),
                  TSize.s16.toHeight,
                  TextFormFieldComponent(
                    title: 'Password',
                    textFieldWithTitle: true,
                    controller: passwordController,
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      onPressed: onShowPassword,
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    hintText: 'Enter your password',
                    validator: TValidator.validatePassword,
                    onChanged: onFieldChanged,
                  ),
                  TSize.s16.toHeight,
                  TextFormFieldComponent(
                    title: 'Confirm password',
                    textFieldWithTitle: true,
                    controller: confirmPasswordController,
                    obscureText: !showConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: onShowConfirmPassword,
                      icon: Icon(
                        showConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                    hintText: 'Enter your password',
                    validator: TValidator.validatePassword,
                    onChanged: onFieldChanged,
                  ),
                  TSize.s16.toHeight,
                  Row(
                    children: [
                      Checkbox(
                        value: agreeToTerms,
                        onChanged: onCheckBoxChanged,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Agree with ',
                              style: theme.textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  TSize.s48.toHeight,
                  ElevatedButton(
                    onPressed: enableButton ? onSignUp : null,
                    child: const TextWidget('Login with Email'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
