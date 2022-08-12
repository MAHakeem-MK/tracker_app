import 'package:firebase_database/firebase_database.dart';

import '../models/user_barcode.dart';



saveBarcode(UserBarcode userBarcode) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("barcodes").push();
  await ref.set(userBarcode.toMap());
}
