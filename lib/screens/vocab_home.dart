import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vocab_provider.dart';
import '../widgets/vocab_tile.dart';
import 'add_word_page.dart';

class VocabHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vocabProvider = Provider.of<VocabProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Vocabulary'),
      ),
      body: vocabProvider.vocabList.isEmpty
          ? Center(
              child: Text(
                'No words added yet!',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: vocabProvider.vocabList.length,
              itemBuilder: (context, index) {
                final vocabWord = vocabProvider.vocabList[index];
                return VocabTile(
                  vocabWord: vocabWord,
                  index: index,
                  onDelete: () {
                    vocabProvider.deleteWord(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddWordPage()),
          );
          if (result != null) {
            vocabProvider.addWord(result['word'], result['meaning']);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
