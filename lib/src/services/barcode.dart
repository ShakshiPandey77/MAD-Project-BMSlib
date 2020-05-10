import 'package:barcode_scan/barcode_scan.dart';

// Method for scanning barcode....
Future<ScanResult> barcodeScanning() async {
  try {
    ScanResult result = await BarcodeScanner.scan();
    //print(result.type);
    //print(result.rawContent);
    return result;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
