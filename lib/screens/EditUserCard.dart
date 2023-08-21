import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_business_cards/database/CardModel.dart';
import 'package:digital_business_cards/database/DatabaseHelper.dart';
import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppButton.dart';
import 'package:digital_business_cards/widgets/AppIconButton.dart';
import 'package:digital_business_cards/widgets/AppInput.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:digital_business_cards/widgets/Background.dart';
import 'package:digital_business_cards/widgets/showPopup.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditUserCard extends StatefulWidget {
  const EditUserCard({Key? key}) : super(key: key);

  @override
  State<EditUserCard> createState() => _EditUserCardState();
}

class _EditUserCardState extends State<EditUserCard> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();
  String _photoUrl = "";
  String _logoUrl = "";
  Uint8List? _photo;
  Uint8List? _logo;
  Color currentColor = oppositePrimaryColor;
  late String id;

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  getJsonData() async {
    // Map<String, dynamic> data = await loadData();
    List<Map<String, dynamic>> list = await DatabaseHelper.getUserCard();
    if (list.isNotEmpty) {
      Map<String, dynamic> data = list[0];
      id = data["id"] ?? Uuid().v1(); // if id not existing, then time dependen id
      _nameController.text = data["name"] ?? '';
      _jobController.text = data["job"] ?? '';
      _webController.text = data["web"] ?? '';
      _emailController.text = data["email"] ?? '';
      _telephoneController.text = data["telephone"] ?? '';
      _mobileController.text = data["mobile"] ?? '';
      _addressController.text = data["address"] ?? '';
      _photoUrl = data["photoUrl"];
      _logoUrl = data["logoUrl"];
      _photoController.text = data["photoUrl"];
      _logoController.text = data["logoUrl"];
    } else {
      id = Uuid().v1();
    }

    // _photo = base64Decode(data["photo"]);
    // _logo = base64Decode(data["logo"]);
    setState(() {
      _photo;
      _logo;
    });
  }



  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _jobController.dispose();
    _webController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _photoController.dispose();
    _logoController.dispose();
  }

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  void save() async {
    Map<String, dynamic> jsonData = {
      'name': _nameController.text,
      'job': _jobController.text,
      'web': _webController.text,
      'email': _emailController.text,
      'telephone': _telephoneController.text,
      'mobile': _mobileController.text,
      'address': _addressController.text,
      'photoUrl': _photoController.text,
      'logoUrl': _logoController.text,
    };

    CardModel userCard = CardModel(
      id: id,
      name: _nameController.text,
      job: _jobController.text,
      web: _webController.text,
      email: _emailController.text,
      telephone: _telephoneController.text,
      mobile: _mobileController.text,
      address: _addressController.text,
      photoUrl: _photoController.text,
      logoUrl: _logoController.text,
      userCard: 1,
    );


    await DatabaseHelper.insertData(userCard);
    showPopup(context, "Erfolgreich eingefügt", "Deine Daten wurden nun erfolgreich gespeichert.");
  }


  @override
  Widget build(BuildContext context) {
    return Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(text: "Karte bearbeiten", title: true),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _nameController, text: "Name", textInputType: TextInputType.text, maxLength: 40),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _jobController, text: "Beruf", textInputType: TextInputType.text, maxLength: 40),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _webController, text: "Webseite", textInputType: TextInputType.text, maxLength: 40),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _emailController, text: "Email", textInputType: TextInputType.emailAddress, maxLength: 40),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _telephoneController, text: "Telefon", textInputType: TextInputType.phone, maxLength: 20),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _mobileController, text: "Mobil", textInputType: TextInputType.phone, maxLength: 20),
                  SizedBox(height: padding,),
                  AppInput(textEditingController: _addressController, text: "Adresse", textInputType: TextInputType.text, maxLength: 80),
                  SizedBox(height: padding,),
                  Row(
                    children: [
                      Expanded(child: AppInput(textEditingController: _photoController, text: "Foto-Url", textInputType: TextInputType.text, maxLength: 300)),
                      SizedBox(width: padding,),
                      AppIconButton(icon: Icons.search, onTap: () {
                        setState(() {
                          _photoUrl = _photoController.text;
                        });
                      })
                    ],
                  ),
                  SizedBox(height: padding,),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _photoUrl == "" || _photoUrl == null ? Icon(Icons.person, size: 150,) : Image.network(_photoController.text, fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(height: padding,),
                  Row(
                    children: [
                      Expanded(child: AppInput(textEditingController: _logoController, text: "Logo-Url", textInputType: TextInputType.text, maxLength: 300)),
                      SizedBox(width: padding,),
                      AppIconButton(icon: Icons.search, onTap: () {
                        setState(() {
                          _logoUrl = _logoController.text;
                        });
                      })
                    ],
                  ),
                  SizedBox(height: padding,),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _logoUrl == "" || _logoUrl == null ? Icon(Icons.house, size: 150,) : Image.network(_logoController.text, fit: BoxFit.cover,),
                    ),
                  ),
                  SizedBox(height: padding,),
                  AppButton(text: "Speichern", onTapFunction: save)
                ],
              ),
            ),
          ),
        )
    );
  }
}
