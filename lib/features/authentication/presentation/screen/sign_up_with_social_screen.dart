import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class SignUpWithSocialScreen extends StatelessWidget {
  static const routeName = '/sign-up-with-social';
  const SignUpWithSocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = sl<LoginController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: TSize.s100,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: TextWidget(
          'Signup to ShopZen',
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
                      text: 'Signup in with ${item.capitalize()}',
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
                OrWidget(),
                TSize.s48.toHeight,
                ElevatedButton(
                  onPressed: () =>
                      GoRouter.of(context).pushNamed(SignUpWithEmailScreen.routeName),
                  child: TextWidget('Signup with Email'),
                ),
                Spacer(),
                AuthenticationRichTextWidget(
                  text: "Already have an account? ",
                  hyperlinkText: "Login",
                  navToSignUp: () =>
                      GoRouter.of(context).pushNamed(LoginWithSocialScreen.routeName),
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
