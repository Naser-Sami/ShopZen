import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class LoginWithEmailScreen extends StatefulWidget {
  static const routeName = '/login-with-email';
  const LoginWithEmailScreen({super.key});

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final loginService = sl<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool enableButton = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    if (_formKey.currentState!.validate()) {
      loginService.loginWithEmail(
        context,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  void onFieldChanged(String? v) {
    if (v == null || v.isEmpty) {
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

  void onShowPassword() {
    setState(() {
      showPassword = !showPassword;
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
                  TSize.s08.toHeight,
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        'Forgot Password?',
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ),
                  TSize.s48.toHeight,
                  ElevatedButton(
                    onPressed: enableButton ? onLogin : null,
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
