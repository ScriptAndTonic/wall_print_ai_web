import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/ui/pages/splash/components/body.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onNext;
  static String routeName = '/splash';

  const SplashScreen({super.key, required this.onNext});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(onGetStarted: onNext),
    );
  }
}
