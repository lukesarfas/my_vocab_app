import 'package:flutter/material.dart';

class AddWordPage extends StatefulWidget {
  @override
  _AddWordPageState createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Word'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _wordController,
              decoration: InputDecoration(labelText: 'Word'),
            ),
            TextField(
              controller: _meaningController,
              decoration: InputDecoration(labelText: 'Meaning'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final word = _wordController.text.trim();
                final meaning = _meaningController.text.trim();
                if (word.isNotEmpty && meaning.isNotEmpty) {
                  Navigator.pop(context, {'word': word, 'meaning': meaning});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Please enter both a word and a meaning')),
                  );
                }
              },
              child: Text('Add Word'),
            ),
          ],
        ),
      ),
    );
  }
}
