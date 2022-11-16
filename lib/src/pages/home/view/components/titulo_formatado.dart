import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/custom_colors.dart';

class TituloFormatado extends StatelessWidget {


  final Color? greenTitleColor;
  final double? textSize;

   TituloFormatado({this.greenTitleColor, this.textSize = 30.0});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.bold,
              color: greenTitleColor ??  CustomColors.customSwacthColor),
          children: [
            TextSpan(
              text: 'Green',
              style: TextStyle(color: greenTitleColor),
            ),
            TextSpan(
              text: 'grocery',
              style: TextStyle(color: CustomColors.customContrastColor),
            ),
          ]),
    );
  }
}
