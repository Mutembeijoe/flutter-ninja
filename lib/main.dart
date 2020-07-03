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
                onPressed: () {},
                child: Text("Convert"),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "42.0",
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
}
