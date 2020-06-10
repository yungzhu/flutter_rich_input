import 'dart:ui';
import 'package:flutter/material.dart';
import 'block_base.dart';

/// Processing of compose texts
class ComposeBlock extends BlockBase {
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
      const TextStyle composingStyle =
          TextStyle(decoration: TextDecoration.underline);
      final text = value.text;
      final composing = value.composing;
      return TextSpan(
        style: composingStyle,
        text: composing.textInside(text),
      );
    }
    return const TextSpan(text: "");
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
