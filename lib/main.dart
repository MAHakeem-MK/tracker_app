import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:tracker_app/views/home_page.dart';
import 'package:tracker_app/views/profile_page.dart';
import 'package:tracker_app/views/signin_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const providerConfigs = [EmailProviderConfiguration()];
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      initialRoute: user == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in': (context) => const SigninPage(providerConfigs: providerConfigs),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(providerConfigs: providerConfigs),
      },
    );
    
  }
}
