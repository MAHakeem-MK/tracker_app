import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanbarcode() {
  return FlutterBarcodeScanner.scanBarcode(
    '#ff6666',
    "Cancel",
    true,
    ScanMode.BARCODE,
  );
}
