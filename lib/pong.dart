import 'package:flutter/material.dart';
import 'package:flutter_ninja/ball.dart';
import 'package:flutter_ninja/bat.dart';
import 'dart:math';

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
  double randX = 1;
  double randY = 1;
  int score = 0;

  // create a random double between 0.5 - 1.5

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void checkBorders() {
    if (posX <= 0 && hdir == Direction.left) {
      hdir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - 50 && hdir == Direction.right) {
      hdir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - (50 + batHeight) && vdir == Direction.down) {
      if (posX >= (batPosition - 50) && posX <= (batPosition + 50 + batWidth)) {
        vdir = Direction.up;
        randY = randomNumber();
        safeSetState(() => score++);
      } else {
        controller.stop();
        openDialogue(context);
        // dispose();
      }
    }
    if (posY <= 0 && vdir == Direction.up) {
      vdir = Direction.down;
      randY = randomNumber();
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
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vdir == Direction.down)
            ? posY += ((increment * randX).round())
            : posY -= ((increment * randX).round());
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
              child: Text(
                'Score: $score',
                style: Theme.of(context).textTheme.headline4,
              ),
              top: 0,
              right: 50,
            ),
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

  void openDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Would you like to play again ?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                posX = 0;
                posY = 0;
                score = 0;
              });
              Navigator.of(context).pop();
              controller.repeat();
            },
            child: Text("Yes"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              dispose();
            },
            child: Text("No"),
          )
        ],
      ),
    );
  }
}
