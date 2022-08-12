import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key, required this.providerConfigs}) : super(key: key);

  final List<ProviderConfiguration> providerConfigs;

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: providerConfigs,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, '/home');
        }),
      ],
    );
  }
}
