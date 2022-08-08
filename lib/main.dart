import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:geolocator/geolocator.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? _position;

  _saveLocation(User user, Position position) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("locations").push();
    await ref.set({
      "time_stamp": DateTime.now().toUtc().toIso8601String(),
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "latitude": position.latitude,
      "longitude": position.longitude,
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _determinePosition().then((value) {
        _saveLocation(user, value);
        setState(() {
          _position = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const providerConfigs = [EmailProviderConfiguration()];

    return MaterialApp(
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providerConfigs: providerConfigs,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ],
          );
        },
        '/home': (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tracker"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/profile');
                    },
                    icon: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ))
              ],
            ),
            body: Center(
              child: Text("${_position?.latitude} ${_position?.longitude}"),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.my_location),
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  _determinePosition().then((value) {
                    _saveLocation(user, value);
                    setState(() {
                      _position = value;
                    });
                  });
                }
              },
            ),
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            providerConfigs: providerConfigs,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
      },
    );
  }
}
