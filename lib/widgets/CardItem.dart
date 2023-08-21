import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const CardItem({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(this.icon, color: white,),
            SizedBox(width: padding,),
            Expanded(child: AppText(text: text)),
          ],
        ),
        SizedBox(height: 5,),
      ],
    );
  }
}
