import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/vocab_word.dart';

class VocabProvider extends ChangeNotifier {
  List<VocabWord> _vocabList = [];

  List<VocabWord> get vocabList => _vocabList;

  VocabProvider() {
    _loadVocabList();
  }

  Future<void> _loadVocabList() async {
    final prefs = await SharedPreferences.getInstance();
    final vocabListString = prefs.getString('vocabList');
    if (vocabListString != null) {
      final List<dynamic> decodedList = jsonDecode(vocabListString);
      _vocabList = decodedList
          .map((item) => VocabWord.fromMap(Map<String, String>.from(item)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveVocabList() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList =
        jsonEncode(_vocabList.map((item) => item.toMap()).toList());
    await prefs.setString('vocabList', encodedList);
  }

  void addWord(String word, String meaning) {
    _vocabList.add(VocabWord(word: word, meaning: meaning));
    _saveVocabList();
    notifyListeners();
  }

  void deleteWord(int index) {
    _vocabList.removeAt(index);
    _saveVocabList();
    notifyListeners();
  }
}
