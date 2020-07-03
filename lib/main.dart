import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Productivity App",
      home: ProductivityHome(),
    );
  }
}

class ProductivityHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Work Timer"),
      ),
      body: Column(
        children: <Widget>[Text("Hello App")],
      ),
    );
  }
}
