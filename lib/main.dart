import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TemperatureConversionHomePage(),
    );
  }
}

class TemperatureConversionHomePage extends StatefulWidget {
  @override
  _TemperatureConversionHomePageState createState() =>
      _TemperatureConversionHomePageState();
}

class _TemperatureConversionHomePageState
    extends State<TemperatureConversionHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    final input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    double converted;
    if (_conversionType == 'F to C') {
      converted = (input - 32) * 5 / 9;
    } else {
      converted = input * 9 / 5 + 32;
    }

    setState(() {
      _result = converted.toStringAsFixed(2);
      _history.add('$_conversionType: $input => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Converter',
          style: TextStyle(
            fontSize: 24, // Set the font size
            fontWeight: FontWeight.bold, // Set the font weight
            color: Colors.white, // Set the font color
            letterSpacing: 1.2, // Set the letter spacing
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: const Text('F to C'),
                            leading: Radio<String>(
                              value: 'F to C',
                              groupValue: _conversionType,
                              onChanged: (String? value) {
                                setState(() {
                                  _conversionType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('C to F'),
                            leading: Radio<String>(
                              value: 'C to F',
                              groupValue: _conversionType,
                              onChanged: (String? value) {
                                setState(() {
                                  _conversionType = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter temperature',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _convertTemperature,
                      child: Text('Convert', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _result.isEmpty ? '' : 'Converted Value: $_result',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: _history
                    .map((conversion) => Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(title: Text(conversion)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
