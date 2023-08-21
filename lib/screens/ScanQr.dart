import 'dart:io';

import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/**
 * Class based on code from qr_code_scanner package https://pub.dev/packages/qr_code_scanner
 */
class ScanQr extends StatefulWidget {
  final Function(String)? onQRCodeScanned;

  const ScanQr({Key? key, this.onQRCodeScanned}) : super(key: key);

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // ...

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    String data = "";
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && scanData.code != "" && scanData.code != "updateAcquireFence: Did not find frame.") {
        data = scanData.code!;
        controller.dispose();
        Navigator.pop(context, data);
      }
    });


  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            // flex: 7,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
