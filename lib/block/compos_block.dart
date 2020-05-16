import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rich_input/block/text_block.dart';

/// Processing of compose texts
class ComposeBlock extends TextBlock {
  ComposeBlock();

  @override
  void add(String char) {
    throw 'error';
  }

  @override
  String del(int count) {
    throw 'error';
  }

  @override
  InlineSpan getSpan(TextEditingValue value) {
    if (value.composing.isValid) {
      TextStyle composingStyle =
          const TextStyle(decoration: TextDecoration.underline);
      var text = value.text;
      var composing = value.composing;
      return TextSpan(
        style: composingStyle,
        text: composing.textInside(text),
      );
    }
    return TextSpan(text: "");
  }

  @override
  String getText() {
    return '';
  }

  @override
  String getValue() {
    return '';
  }
}
