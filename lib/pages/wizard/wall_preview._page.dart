import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/pages/components/resizable_widget.dart';

class WallPreviewPage extends StatelessWidget {
  final Image painting;
  final ImageProvider roomImage;
  const WallPreviewPage(
      {Key? key, required this.painting, required this.roomImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: roomImage),
        ),
        padding: const EdgeInsets.all(60),
        child: ResizableWidget(
          child: painting,
        ),
      ),
    );
  }
}
