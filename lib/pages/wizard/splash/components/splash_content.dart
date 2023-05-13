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
        Center(
          child: SizedBox(
            height: 80,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: kSecondaryColor,
          ),
        ),
        const Spacer(flex: 2),
        Image.asset(image!),
      ],
    );
  }
}
