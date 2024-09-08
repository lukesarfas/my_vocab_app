class VocabWord {
  final String word;
  final String meaning;

  VocabWord({required this.word, required this.meaning});

  // Access word and meaning using [] operator
  String operator [](String key) {
    switch (key) {
      case 'word':
        return word;
      case 'meaning':
        return meaning;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }

  // Convert VocabWord to Map (for storage)
  Map<String, String> toMap() {
    return {
      'word': word,
      'meaning': meaning,
    };
  }

  // Create VocabWord from Map (when loading from storage)
  factory VocabWord.fromMap(Map<String, String> map) {
    return VocabWord(
      word: map['word']!,
      meaning: map['meaning']!,
    );
  }
}
