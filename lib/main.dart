import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(EpochTimeConverterApp());
}

class EpochTimeConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epoch Time Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EpochTimeConverterPage(),
    );
  }
}

class EpochTimeConverterPage extends StatefulWidget {
  @override
  _EpochTimeConverterPageState createState() => _EpochTimeConverterPageState();
}

class _EpochTimeConverterPageState extends State<EpochTimeConverterPage> {
  final _epochController = TextEditingController();
  String _convertedTime = '';

  void _convertEpochToTime() {
    final epoch = int.tryParse(_epochController.text);
    if (epoch != null) {
      final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
      setState(() {
        _convertedTime = formattedDate;
      });
    } else {
      setState(() {
        _convertedTime = 'Invalid epoch time';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Epoch Time Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _epochController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Epoch Time',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertEpochToTime,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _convertedTime,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
