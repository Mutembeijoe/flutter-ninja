import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final double size;
  final Color color;
  final String text;
  final VoidCallback callback;

  ProductivityButton(
      {@required this.color,
      @required this.callback,
      @required this.size,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.callback,
      color: this.color,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: this.size,
    );
  }
}
