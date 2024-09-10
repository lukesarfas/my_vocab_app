import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddWordPage extends StatefulWidget {
  @override
  _AddWordPageState createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController _wordController = TextEditingController();
  TextEditingController _meaningController = TextEditingController();
  bool _isLoading = false;

  // Method to fetch definition from the Free Dictionary API
  Future<void> _fetchDefinition() async {
    final word = _wordController.text.trim();
    print(word);

    if (word.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty && data[0]['meanings'] != null) {
          final meaning =
              data[0]['meanings'][0]['definitions'][0]['definition'];

          setState(() {
            _meaningController.text = meaning;
          });
        } else {
          _showErrorDialog('No definition found for this word.');
        }
      } else {
        _showErrorDialog('Failed to fetch the definition.');
      }
    } catch (error) {
      print(error);
      _showErrorDialog('An error occurred while fetching the definition.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Method to show error dialogs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _wordController,
              decoration: InputDecoration(labelText: 'Word'),
            ),
            SizedBox(height: 10),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _fetchDefinition,
                child: Text('Fetch Definition'),
              ),
            SizedBox(height: 10),
            TextField(
              controller: _meaningController,
              decoration: InputDecoration(labelText: 'Meaning'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'word': _wordController.text,
                  'meaning': _meaningController.text,
                });
              },
              child: Text('Add Word'),
            ),
          ],
        ),
      ),
    );
  }
}
