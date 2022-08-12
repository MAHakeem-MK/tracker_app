import 'package:firebase_database/firebase_database.dart';

import '../models/user_location.dart';

saveLocation(UserLocation userLocation) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("locations").push();
  await ref.set(userLocation.toMap());
}
