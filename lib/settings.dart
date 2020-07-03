import 'package:flutter/material.dart';
import 'package:flutter_ninja/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextStyle textStyle = TextStyle(fontSize: 24);
  SharedPreferences prefs;

  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;

  final int buttonSize = 50;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtShort.text = shortBreak.toString();
      txtWork.text = workTime.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;

          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK);
          short += value;

          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK);
          long += value;

          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = txtLong.toString();
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          childAspectRatio: 2,
          crossAxisSpacing: 10,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text("Work", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(Color(0xff455A64), "-", buttonSize, -1, WORKTIME,
                updateSettings),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtWork,
            ),
            SettingsButton(Color(0xff009688), "+", buttonSize, 1, WORKTIME,
                updateSettings),
            Text("Short", style: textStyle),
            Text(""),
            Text(""),
            SettingsButton(Color(0xff455A64), "-", buttonSize, -1, SHORTBREAK,
                updateSettings),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtShort,
            ),
            SettingsButton(
              Color(0xff009688),
              "+",
              buttonSize,
              1,
              SHORTBREAK,
              updateSettings,
            ),
            Text(
              "Long",
              style: textStyle,
            ),
            Text(""),
            Text(""),
            SettingsButton(
              Color(0xff455A64),
              "-",
              buttonSize,
              -1,
              LONGBREAK,
              updateSettings,
            ),
            TextField(
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: txtLong,
            ),
            SettingsButton(
              Color(0xff009688),
              "+",
              buttonSize,
              1,
              LONGBREAK,
              updateSettings,
            ),
          ],
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}
