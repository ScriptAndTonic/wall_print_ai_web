import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/size_config.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getScreenWidthFromPercentage(80),
      height: getProportionateScreenHeight(56),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: kPrimaryColor,
        ),
        onPressed: press as void Function()?,
        label: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
        icon: Icon(icon),
      ),
    );
  }
}
