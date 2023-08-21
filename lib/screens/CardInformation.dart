import 'dart:convert';

import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppIconButton.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:digital_business_cards/widgets/Background.dart';
import 'package:digital_business_cards/widgets/CardItem.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardInformation extends StatefulWidget {
  final Map<String, dynamic> data;
  const CardInformation({Key? key, required this.data}) : super(key: key);

  @override
  State<CardInformation> createState() => _CardInformationState();
}

class _CardInformationState extends State<CardInformation> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    widget.data["name"] != "" ? AppText(text: widget.data["name"], title: true,) : SizedBox(height: 0,),
                    SizedBox(height: padding,),
                    Row(
                      mainAxisAlignment: widget.data["photoUrl"] != "" && widget.data["logoUrl"] != "" ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                      children: [
                        widget.data["photoUrl"] != "" ? Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.data["photoUrl"], fit: BoxFit.cover,),
                          ),
                        ) : SizedBox(width: 0,),
                        widget.data["logoUrl"] != "" ? Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.data["logoUrl"], fit: BoxFit.cover,),
                          ),
                        ) : SizedBox(width: 0,),
                      ],
                    ),
                    SizedBox(height: padding,),
                    Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(padding)),
                      ),
                      padding: EdgeInsets.all(padding),
                      child: PrettyQr(
                        image: AssetImage('assets/images/app_logo.png'),
                        size: 250,
                        data: jsonEncode(widget.data),
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        typeNumber: null,
                        roundEdges: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: padding,),
                          widget.data["job"] != "" ? CardItem(text: widget.data["job"], icon: Icons.work) : SizedBox(height: 0,),
                          widget.data["web"] != "" ? CardItem(text: widget.data["web"], icon: Icons.web) : SizedBox(height: 0,),
                          widget.data["email"] != "" ? CardItem(text: widget.data["email"], icon: Icons.email) : SizedBox(height: 0,),
                          widget.data["telephone"] != "" ? CardItem(text: widget.data["telephone"], icon: Icons.phone) : SizedBox(height: 0,),
                          widget.data["mobile"] != "" ? CardItem(text: widget.data["mobile"], icon: Icons.smartphone) : SizedBox(height: 0,),
                          widget.data["address"] != "" ? CardItem(text: widget.data["address"], icon: Icons.location_city ) : SizedBox(height: 0,),
                        ],
                      ),
                    ),




                  ],
                ),
              ),
              widget.data["userCard"] == 0 ? Positioned(
                  top: 5,
                  right: 5,
                  child: AppIconButton(
                    icon: Icons.close,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
              ) : SizedBox(height: 0,)
            ],
          ),
        ),
      ),
    );
  }
}
