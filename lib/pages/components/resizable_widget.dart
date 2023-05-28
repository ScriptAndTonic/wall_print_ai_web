import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/size_config.dart';

class ResizableWidget extends StatefulWidget {
  const ResizableWidget({super.key, required this.child});

  final Widget child;

  @override
  ResizableWidgetState createState() => ResizableWidgetState();
}

const ballDiameter = 30.0;
const transparentHandleSize = 80.0;

class ResizableWidgetState extends State<ResizableWidget> {
  double height = 100;
  double width = 100;

  double top = (SizeConfig.screenHeight / 2);
  double left = (SizeConfig.screenWidth / 2);

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: SizedBox(
            height: height,
            width: width,
            child: widget.child,
          ),
        ),
        // bottom right
        Positioned(
          top: top + height,
          left: left + width,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // center center
        Positioned(
          top: top + height / 2 - transparentHandleSize / 2,
          left: left + width / 2 - transparentHandleSize / 2,
          child: TransparentManipulatingHandle(
            onDrag: (dx, dy) {
              setState(() {
                top = top + dy;
                left = left + dx;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({super.key, required this.onDrag});

  final Function onDrag;

  @override
  ManipulatingBallState createState() => ManipulatingBallState();
}

class ManipulatingBallState extends State<ManipulatingBall> {
  double initX = 0;
  double initY = 0;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Transform.rotate(
          angle: 45,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: ballDiameter,
          ),
        ),
      ),
    );
  }
}

class TransparentManipulatingHandle extends StatefulWidget {
  const TransparentManipulatingHandle({super.key, required this.onDrag});

  final Function onDrag;

  @override
  TransparentManipulatingHandleState createState() =>
      TransparentManipulatingHandleState();
}

class TransparentManipulatingHandleState
    extends State<TransparentManipulatingHandle> {
  double initX = 0;
  double initY = 0;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: transparentHandleSize,
        height: transparentHandleSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
