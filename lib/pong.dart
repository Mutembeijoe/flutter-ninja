import 'package:flutter/material.dart';
import 'package:flutter_ninja/ball.dart';
import 'package:flutter_ninja/bat.dart';

enum Direction { up, down, right, left }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Direction vdir = Direction.down;
  Direction hdir = Direction.right;
  int increment = 5;
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  void checkBorders() {
    if (posX <= 0 && hdir == Direction.left) {
      hdir = Direction.right;
    }
    if (posX >= width - 50 && hdir == Direction.right) {
      hdir = Direction.left;
    }
    if (posY >= height - (50 + batHeight) && vdir == Direction.down) {
      if (posX >= (batPosition - 50) && posX <= (batPosition + 50 + batWidth)) {
        vdir = Direction.up;
      } else {
        controller.stop();
        dispose();
      }
    }
    if (posY <= 0 && vdir == Direction.up) {
      vdir = Direction.down;
    }
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        minutes: 1000,
      ),
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hdir == Direction.right)
            ? posX = posX + increment
            : posX = posX - increment;
        (vdir == Direction.down)
            ? posY = posY + increment
            : posY = posY - increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        width = constraints.maxWidth;
        height = constraints.maxHeight;
        batWidth = width / 5;
        batHeight = height / 20;
        return Stack(
          // alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: posY,
              left: posX,
              child: Ball(),
            ),
            Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) {
                  return moveBat(update);
                },
                child: Bat(
                  height: batHeight,
                  width: batWidth,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      print("moving bat");
      batPosition += update.delta.dx;
    });
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }
}
