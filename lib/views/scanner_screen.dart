import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();

  bool isScanned = false;

  void checkBarcode(String code) async {
    if (isScanned) return;

    isScanned = true;

    // ⛔ STOP camera after scan
    await cameraController.stop();

    int lastDigit = int.tryParse(code[code.length - 1]) ?? 1;
    bool isValid = lastDigit % 2 == 0;

    String productName = "Unknown Product";

    // if (code.endsWith("2")) productName = "Pen";
    // else if (code.endsWith("4")) productName = "Notebook";
    // else if (code.endsWith("6")) productName = "Sketch Book";
    // else if (code.endsWith("8")) productName = "Color Pencils";

    Get.dialog(
      AlertDialog(
        title: Text("Scan Result"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Barcode: $code"),
            SizedBox(height: 10),
            Text("Product: $productName"),
            SizedBox(height: 10),
            Text(
              isValid ? "✅ Valid" : "❌ Invalid",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isValid ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              isScanned = false;
              await cameraController.start();
            },
            child: Text("Scan Again"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Barcode Scanner")),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            
            if (code != null) {
              checkBarcode(code);
              break;
            }
          }
        },
      ),
    );
  }
}