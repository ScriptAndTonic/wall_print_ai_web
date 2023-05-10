import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/size_config.dart';
import 'package:wall_print_ai_web/pages/wizard/splash/components/splash_content.dart';
import 'package:wall_print_ai_web/pages/ui_components/custom_submit_button.dart';

class Body extends StatefulWidget {
  final Function() onGetStarted;
  const Body({super.key, required this.onGetStarted});

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  int currentPage = 0;
  Map<String, String> splashData = {
    'text': 'Make your place Beautiful!',
    'image': 'assets/images/woman_on_couch.jpg'
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SplashContent(
                image: splashData['image'],
                text: splashData['text'],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(flex: 2),
                    CustomSubmitButton(
                      text: 'Get Started',
                      press: widget.onGetStarted,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
