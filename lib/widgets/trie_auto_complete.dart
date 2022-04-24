import 'package:flutter/material.dart';
import 'package:retrieval/trie.dart';

class TrieAutocomplete extends StatefulWidget {
  const TrieAutocomplete({Key key}) : super(key: key);

  @override
  State<TrieAutocomplete> createState() => TrieAutocompleteState();
}

class TrieAutocompleteState extends State<TrieAutocomplete> {
  static const List<String> _options = <String>[
    'emu',
    'echidna',
    'cassowary',
    'koala',
    'kookaburra',
  ];

  final Trie _trie = Trie();

  @override
  void initState() {
    for (final option in _options) {
      _trie.insert(option);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _findCompletions(textEditingValue.text.toLowerCase());
      },
      onSelected: (String selection) {
        debugPrint('You selected $selection');
      },
    );
  }

  Iterable<String> _findCompletions(String query) => _trie.find(query);
}