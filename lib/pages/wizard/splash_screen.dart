import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/constants.dart';
import 'package:wall_print_ai_web/pages/ui_components/custom_submit_button.dart';
import 'package:wall_print_ai_web/size_config.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onNext;

  const SplashScreen({super.key, required this.onNext});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Text(
                      'Art prints that match your space',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/work_from_home.png'),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSubmitButton(
                  text: 'Get Started',
                  press: widget.onNext,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
