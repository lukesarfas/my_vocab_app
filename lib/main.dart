import 'package:flutter/material.dart';
import 'package:my_vocab_app/screens/vocab_home.dart';
import 'package:provider/provider.dart';
import 'providers/vocab_provider.dart';
import 'screens/add_word_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VocabProvider(),
      child: MyVocabApp(),
    ),
  );
}

class MyVocabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocab App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VocabHomePage(),
    );
  }
}
