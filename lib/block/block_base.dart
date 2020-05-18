import 'package:flutter/material.dart';

/// Text block base class
abstract class BlockBase {
  /// Start position of additions and deletions
  int startIndex = 0;

  BlockBase();

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
