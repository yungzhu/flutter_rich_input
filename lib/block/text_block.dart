import 'package:flutter/material.dart';

abstract class TextBlock {
  /// Start position of additions and deletions
  int startIndex = 0;

  TextBlock();

  /// Add characters
  void add(String char);

  /// Delete character
  String del(int count);

  /// Get the rendered text
  InlineSpan getSpan(TextEditingValue value);

  /// Text displayed
  String getText();

  /// Value output
  String getValue();
}
