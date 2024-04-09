
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';


class QRCodeScanner extends StatefulWidget {
  QRCodeScanner({super.key});

  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoStart: true,
  );

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: widget.controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          Barcode barcode = barcodes[0];

          debugPrint('Barcode found! ${barcodes[0].rawValue}');
          setState(() {
            widget.controller.stop();
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Barcode found!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: foodItemsData.isNotClaimed(id: barcode.rawValue)
                  ? const Text(
                      "Do you want to claim this bill?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      'This bill has already been claimed! OR Bill ID is invalid!',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      widget.controller.start();
                    });
                  },
                ),
                if (foodItemsData.isNotClaimed(id: barcodes[0].rawValue))
                  CupertinoDialogAction(
                    child: const Text('Claim'),
                    onPressed: () {
                      foodItemsData.claimBillWithId(id: barcodes[0].rawValue);
                      Navigator.pop(context);
                      setState(() {
                        widget.controller.start();
                      });
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
