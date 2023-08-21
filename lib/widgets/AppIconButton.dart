import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final Color colorOne;
  final Color colorTwo;
  final double padding;
  final double iconSize;
  final Color iconColor;
  final String text;

  const AppIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.colorOne = oppositePrimaryColor,
    this.colorTwo = oppositeSecondaryColor,
    this.padding = 12,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [colorOne, colorTwo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
              SizedBox(width: text != "" ? 5 : 0,),
              AppText(text: text,)
            ],
          )),
    );
  }
}
