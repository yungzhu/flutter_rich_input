import 'package:flutter/material.dart';
import 'package:flutter_rich_input/block/text_block.dart';

/// Processing @text
class AtBlock extends TextBlock {
  String text;
  String value;
  AtBlock(this.text, this.value);

  @override
  void add(String chat) {
    throw 'error';
  }

  @override
  String del(int count) {
    throw 'error';
  }

  @override
  InlineSpan getSpan(TextEditingValue value) {
    return TextSpan(
      text: getText(),
      style: const TextStyle(color: Colors.blue),
    );
  }

  @override
  String getText() {
    return text;
  }

  @override
  String getValue() {
    if (value != null) return value.toString();
    return text;
  }
}
