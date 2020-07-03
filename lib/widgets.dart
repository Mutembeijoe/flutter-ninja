import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final double size;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  ProductivityButton(
      {@required this.color,
      @required this.onPressed,
      @required this.size,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      color: this.color,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      minWidth: this.size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;
  SettingsButton(this.color, this.text, this.value, this.size, this.setting,
      this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
      // minWidth: this.size,
    );
  }
}
