import 'package:flutter/material.dart';
import '../models/vocab_word.dart';

class VocabTile extends StatelessWidget {
  final VocabWord vocabWord;
  final int index;
  final VoidCallback onDelete;

  VocabTile(
      {required this.vocabWord, required this.index, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(vocabWord.word),
      subtitle: Text(vocabWord.meaning),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
