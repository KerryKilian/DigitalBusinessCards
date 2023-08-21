import 'package:digital_business_cards/utils/colors.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Color colorOne;
  final Color colorTwo;
  const Background({Key? key, required this.child, this.colorOne = primaryColor, this.colorTwo = secondaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    colorOne == null ? secondaryColor : colorOne;
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorOne, colorTwo],
            ),
          ),
          child: this.child),
    );

  }
}