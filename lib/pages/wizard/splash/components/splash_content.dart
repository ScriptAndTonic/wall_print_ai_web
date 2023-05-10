import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          'Visualio',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(image!),
      ],
    );
  }
}
