import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Convertor',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _valueToConvert;
  String _initialMeasure;
  String _finalMeasure;
  String _resultMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unit Convertor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Value",
                style: labelStyle,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Insert the value to convert"),
                onChanged: (String val) {
                  var value = double.tryParse(val);
                  if (val != null) {
                    setState(() {
                      _valueToConvert = value;
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('From', style: labelStyle),
              SizedBox(
                height: 20,
              ),
              DropdownButton(
                isExpanded: true,
                hint: Text("Select Unit"),
                value: _initialMeasure,
                items: _measures
                    .map((val) => DropdownMenuItem(
                          child: Text(
                            val,
                            style: inputStyle,
                          ),
                          value: val,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _initialMeasure = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('To', style: labelStyle),
              SizedBox(
                height: 20,
              ),
              DropdownButton(
                isExpanded: true,
                hint: Text("Select Unit"),
                value: _finalMeasure,
                items: _measures
                    .map((val) => DropdownMenuItem(
                          child: Text(
                            val,
                            style: inputStyle,
                          ),
                          value: val,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _finalMeasure = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  if (_initialMeasure.isEmpty ||
                      _finalMeasure.isEmpty ||
                      _valueToConvert == 0) {
                    return;
                  } else {
                    convert(_valueToConvert, _initialMeasure, _finalMeasure);
                  }
                },
                child: Text("Convert"),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                _resultMessage,
                style: inputStyle,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );
  TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      _resultMessage = "Invalid conversion";
    } else {
      _resultMessage =
          '${_valueToConvert.toString()} $_initialMeasure = ${result.toString()} $_finalMeasure';

      setState(() {
        _resultMessage = _resultMessage;
      });
    }
  }
}
