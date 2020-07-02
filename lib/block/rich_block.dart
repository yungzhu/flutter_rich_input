import 'package:flutter/material.dart';
import 'block_base.dart';

/// Processing rich block
class RichBlock extends BlockBase {
  @protected
  String text;
  @protected
  String value;

  final TextStyle style;
  RichBlock({@required this.text, this.value, this.style});

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
    return TextSpan(
      text: getText(),
      style: style ?? const TextStyle(color: Colors.blue),
    );
  }

  @override
  String getText() {
    return text ?? "";
  }

  @override
  String getValue() {
    if (value != null) return value.toString();
    return text ?? "";
  }
}
