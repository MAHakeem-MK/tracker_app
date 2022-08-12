import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.providerConfigs})
      : super(key: key);

  final List<ProviderConfiguration> providerConfigs;

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      providerConfigs: providerConfigs,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }),
      ],
    );
  }
}
