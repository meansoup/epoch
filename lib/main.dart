import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:highlight_text/highlight_text.dart';

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
  final _inputController = TextEditingController();
  List<MapEntry<String, String>> _convertedTimes = [];
  Map<String, HighlightedWord> _highlights = {};

  void _highlightAndConvert() {
    final inputText = _inputController.text;
    final epochRegex = RegExp(r'\b\d{10}\b');  // Assuming epoch time is 10 digits
    final matches = epochRegex.allMatches(inputText);

    setState(() {
      _convertedTimes.clear();
      _highlights.clear();

      if (matches.isNotEmpty) {
        for (final match in matches) {
          final epochString = match.group(0)!;
          final epoch = int.tryParse(epochString);
          if (epoch != null) {
            final date = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
            final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
            _convertedTimes.add(MapEntry(epochString, formattedDate));
            _highlights[epochString] = HighlightedWord(
              onTap: () {},
              textStyle: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }
      }
    });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _inputController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text with Epoch Time',
                  ),
                  onChanged: (_) => _highlightAndConvert(),
                ),
              )
            ),
            SizedBox(height: 20),
            Text(
              'Converted Times:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _convertedTimes.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text('${entry.key}: ${entry.value}',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              )
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: TextHighlight(
                  text: _inputController.text,
                  words: _highlights,
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
