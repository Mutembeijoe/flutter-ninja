import 'package:flutter/material.dart';
import 'package:flutter_ninja/settings.dart';
import 'package:flutter_ninja/timer.dart';
import 'package:flutter_ninja/timerModel.dart';
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
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double _defaultPadding = 7.0;
  final CountDownTimer timer = CountDownTimer();
  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();

    menuItems.add(PopupMenuItem(
      child: Text("Settings"),
      value: "Settings",
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("My Work Timer"),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (value) {
              if (value == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
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
                      onPressed: () => timer.startWork(),
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
                      onPressed: () => timer.startBreak(true),
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
                      onPressed: () => timer.startBreak(false),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_defaultPadding),
                  ),
                ],
              ),
              StreamBuilder<TimerModel>(
                  stream: timer.stream(),
                  builder: (context, snapshot) {
                    // print("building");
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableHeight / 2,
                        lineWidth: 10.0,
                        percent:
                            snapshot.hasData ? snapshot.data.percentage : 0,
                        center: new Text(
                          '${snapshot.hasData ? snapshot.data.time : '00:00'}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        progressColor: Colors.green,
                      ),
                    );
                  }),
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
                      onPressed: () => timer.stopTimer(),
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
                      onPressed: () => timer.startTimer(),
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
