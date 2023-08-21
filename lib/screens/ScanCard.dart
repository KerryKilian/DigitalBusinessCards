import 'package:digital_business_cards/database/CardModel.dart';
import 'package:digital_business_cards/database/DatabaseHelper.dart';
import 'package:digital_business_cards/screens/ScanQr.dart';
import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppIconButton.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:digital_business_cards/widgets/Background.dart';
import 'package:digital_business_cards/widgets/showPopup.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class ScanCard extends StatefulWidget {

  const ScanCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanCard> createState() => _ScanCardState();
}

class _ScanCardState extends State<ScanCard> {
  String messageForUser = "";

  void _navigateToScanQRCode(BuildContext context) async {
    final scannedData = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => ScanQr(),
      ),
    );

    if (scannedData != null) {
      Map<String, dynamic> receivedDataJson = {};
      try {
        receivedDataJson = jsonDecode(scannedData);
        CardModel cardModel = CardModel(
            id: receivedDataJson["id"],
            name: receivedDataJson["name"],
            job: receivedDataJson["name"],
            web: receivedDataJson["web"],
            email: receivedDataJson["email"],
            telephone: receivedDataJson["telephone"],
            mobile: receivedDataJson["mobile"],
            address: receivedDataJson["address"],
            photoUrl: receivedDataJson["photoUrl"],
            logoUrl: receivedDataJson["logoUrl"],
            userCard: 0);
        await DatabaseHelper.insertData(cardModel);
        showPopup(context, "Erfolgreich gelesen", "Der QR Code wurde erfolgreich gelesen und gespeichert. Sieh nun in deiner Liste nach.");

      } catch (err) {
        print(err);
        setState(() {
          messageForUser = "Du musst einen QR Code aus der App scannen";
        });
      }
      // saveQRCodeToFile();
    } else {
      // No data was scanned
      print('No QR code was scanned');
      messageForUser = "Es wurde kein QR Code gefunden";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Background(
        child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    AppText(text: "Senden & Empfangen", title: true,),
                    SizedBox(height: 2*padding,),
                    AppText(text: "QR Code", title: true,),
                    SizedBox(height: padding,),
                    AppIconButton(icon: Icons.photo_camera, onTap: () {
                      _navigateToScanQRCode(context);
                    }, text: "Scannen", iconColor: white),
                    SizedBox(height: padding,),
                    AppText(text: messageForUser ?? ""),
          ],
        ),
      ),
    )));
  }
}
