import 'package:flutter/material.dart';
import 'package:flutter_ninja/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Productivity App",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: ProductivityHome(),
    );
  }
}

class ProductivityHome extends StatelessWidget {
  final double _defaultPadding = 7.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Work Timer"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(_defaultPadding),
              ),
              Expanded(
                child: ProductivityButton(
                  text: "Work",
                  color: Color(0xff009688),
                  size: 20,
                  callback: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_defaultPadding),
              ),
              Expanded(
                child: ProductivityButton(
                  text: "Short Break",
                  color: Color(0xff607D8B),
                  size: 20,
                  callback: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_defaultPadding),
              ),
              Expanded(
                child: ProductivityButton(
                  text: "Long Break",
                  color: Color(0xff455A64),
                  size: 20,
                  callback: () {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_defaultPadding),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
