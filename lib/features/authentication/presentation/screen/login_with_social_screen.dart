import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class LoginWithSocialScreen extends StatelessWidget {
  static const routeName = '/login-with-social';
  const LoginWithSocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = sl<AuthController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: TSize.s100,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: TextWidget(
          'Login to ShopZen',
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                for (var item in loginController.socialMediaLogin)
                  Padding(
                    padding: const EdgeInsets.only(bottom: TPadding.p16),
                    child: SocialMediaAuthenticationWidget(
                      icon: item,
                      text: 'Login with ${item.capitalize()}',
                      onPressed: () {
                        switch (item) {
                          case 'google':
                            loginController.loginWithGoogle(context);
                            break;
                          case 'apple':
                            loginController.loginWithApple(context);
                            break;
                          case 'x':
                            loginController.loginWithX(context);
                            break;
                          case 'facebook':
                            loginController.loginWithFacebook(context);
                            break;
                          case 'github':
                            loginController.loginWithGithub(context);
                            break;
                        }
                      },
                    ),
                  ),
                TSize.s48.toHeight,
                const OrWidget(),
                TSize.s48.toHeight,
                ElevatedButton(
                  onPressed: () =>
                      context.push(LoginWithEmailScreen.routeName),
                  child: const TextWidget('Login with Email'),
                ),
                const Spacer(),
                AuthenticationRichTextWidget(
                  text: "Don't have an account yet? ",
                  hyperlinkText: "Sign up",
                  navToSignUp: () =>
                      context.push(SignUpWithSocialScreen.routeName),
                ),
                TSize.s20.toHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
