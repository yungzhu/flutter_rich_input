import 'package:flutter/material.dart';
import 'block_base.dart';

/// Processing of common texts
class TextBlock extends BlockBase {
  @protected
  String text;
  final TextStyle style;
  TextBlock({this.text = "", this.style}) : assert(text != null);

  @override
  void add(String char) {
    text = text.substring(0, startIndex) + char + _getFromIndex(startIndex);
  }

  @override
  String del(int count) {
    final str = text.substring(startIndex, startIndex + count);
    text = text.substring(0, startIndex) + _getFromIndex(startIndex + count);
    return str;
  }

  String _getFromIndex(int index) {
    if (index < text.length) {
      return text.substring(index, text.length);
    }
    return "";
  }

  @override
  InlineSpan getSpan(TextEditingValue value) {
    return TextSpan(text: text);
  }

  @override
  String getText() {
    return text;
  }

  @override
  String getValue() {
    return text;
  }
}
