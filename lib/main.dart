import 'package:flutter/material.dart';
import 'package:flutter_ninja/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableHeight = constraints.maxHeight;
          return Column(
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
              Expanded(
                child: CircularPercentIndicator(
                  radius: availableHeight / 2,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: new Text("100%"),
                  progressColor: Colors.green,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      text: "Stop",
                      color: Color(0xff212121),
                      size: 20,
                      callback: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      text: "Restart",
                      color: Color(0xff009688),
                      size: 20,
                      callback: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
