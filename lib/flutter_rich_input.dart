library flutter_rich_input;

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rich_input/block/common_block.dart';
import 'package:flutter_rich_input/block/compos_block.dart';
import 'package:flutter_rich_input/block/text_block.dart';
import 'extend/rich_text_field.dart';

/// Rich input box, implement @someone and color highlighting
class RichInput {
  /// Get the input widget
  RichTextField textField({
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType,
    TextInputAction textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    TextDirection textDirection,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool autofocus = false,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    bool maxLengthEnforced = true,
    void Function(String) onChanged,
    void Function() onEditingComplete,
    void Function(String) onSubmitted,
    List<TextInputFormatter> inputFormatters,
    bool enabled,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    BoxHeightStyle selectionHeightStyle = BoxHeightStyle.tight,
    BoxWidthStyle selectionWidthStyle = BoxWidthStyle.tight,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    void Function() onTap,
    Widget Function(BuildContext,
            {int currentLength, bool isFocused, int maxLength})
        buildCounter,
    ScrollController scrollController,
    ScrollPhysics scrollPhysics,
  }) {
    this.controller = controller ?? TextEditingController();
    return RichTextField(
      richTextBuilder: (TextEditingValue value, TextStyle style) {
        List<InlineSpan> children = [];
        _list.forEach((f) {
          children.add(f.getSpan(value));
        });

        return TextSpan(
          style: style,
          children: children,
        );
      },
      controller: _controller,
      key: key,
      focusNode: focusNode,
      decoration: decoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      textDirection: textDirection,
      readOnly: readOnly,
      toolbarOptions: toolbarOptions,
      showCursor: showCursor,
      autofocus: autofocus,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      maxLengthEnforced: maxLengthEnforced,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      onTap: onTap,
      buildCounter: buildCounter,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
    );
  }

  TextEditingValue _old;
  TextEditingController _controller;
  List<TextBlock> _list = [];
  int _cursorOffset;
  ComposeBlock _composeText = ComposeBlock();

  TextEditingController get controller {
    return _controller;
  }

  set controller(TextEditingController value) {
    if (_controller == value) return;
    _controller = value;
    _old = _controller.value;
    bool flag = false;

    _controller.addListener(() {
      // print("---------text changed------------");
      TextEditingValue now = _controller.value;
      // print(now);
      if (now.composing.isValid) {
        if (!flag) {
          flag = true;

          // Delete the generated one character first.
          _delByIndex(_cursorOffset - 1, false);
          _cursorOffset--;
          _old = _getEditingValue();

          _addText(_composeText);
        }
        return;
      } else if (flag) {
        flag = false;
        _list.remove(_composeText);
      }
      int oldCount = _old.text.length;
      int nowCount = now.text.length;
      _cursorOffset = now.selection.baseOffset;

      if (oldCount < nowCount) {
        // add value
        _handleAdd();
      } else if (oldCount > nowCount) {
        // del value
        _handleDel();
      } else {
        // move cursor
        // _handleMove();
        return;
      }

      _refresh();
    });
  }

  /// Get value
  String get value {
    var text = "";
    _list.forEach((f) {
      text += f.getValue();
    });
    return text;
  }

  /// Get display text
  String get text {
    var text = "";
    _list.forEach((f) {
      text += f.getText();
    });
    return text;
  }

  /// Add a text block
  void add(TextBlock text) {
    _addText(text);
    _cursorOffset += text.getText().length;
    _refresh();
  }

  void _addText(TextBlock text) {
    TextBlock current = _getByIndex(_cursorOffset);
    if (current == null) {
      _list.add(text);
    } else if (current is CommonBlock && current.getText().length > 0) {
      var delStr = current.del(current.getText().length - current.startIndex);
      var index = _list.indexOf(current);
      _list.insert(index + 1, text);
      if (delStr.length > 0) {
        var newText = CommonBlock(delStr);
        _list.insert(index + 2, newText);
      }
    } else {
      var index = _list.indexOf(current);
      if (index == _list.length - 1) {
        _list.add(text);
      } else {
        _list.insert(index + 1, text);
      }
    }
  }

  void _refresh() {
    _old = _getEditingValue();
    // _debug();
    _controller.value = _old;
  }

  void _handleAdd() {
    TextEditingValue now = _controller.value;
    int oldCount = _old.text.length;
    int nowCount = now.text.length;

    if (nowCount - oldCount == 1) {
      int start = now.selection.baseOffset - 1;
      _addByIndex(start, start + 1);
    } else {
      var from = 0;
      while (from < oldCount) {
        if (_old.text.codeUnitAt(from) != now.text.codeUnitAt(from)) {
          break;
        }
        from++;
      }
      var to = nowCount - oldCount + from;
      // print("add from $from to:$to");
      _addByIndex(from, to);
    }
  }

  void _addByIndex(int from, int to) {
    String char = _controller.value.text.substring(from, to);
    TextBlock text = _getByIndex(from);
    if (text == null || !(text is CommonBlock)) {
      // print("===new text===");
      text = CommonBlock();
      _list.add(text);
    }
    text.add(char);
  }

  TextBlock _getByIndex(int from) {
    var index = 0;
    TextBlock item;
    for (var i = 0; i < _list.length; i++) {
      if (from >= index) {
        item = _list[i];
        item.startIndex = from - index;
        index += item.getText().length;
      } else {
        break;
      }
    }
    return item;
  }

  void _handleDel() {
    TextEditingValue now = _controller.value;
    int oldCount = _old.text.length;
    int nowCount = now.text.length;

    if (nowCount == 0) {
      _list.clear();
    } else if (oldCount - nowCount == 1) {
      _delByIndex(now.selection.baseOffset, true);
    } else {
      var from = 0;
      while (from < nowCount) {
        if (_old.text.codeUnitAt(from) != now.text.codeUnitAt(from)) {
          break;
        }
        from++;
      }
      var to = oldCount - nowCount + from - 1;
      // print("del from $from to:$to");

      while (to >= from) {
        var num = _delByIndex(to, false);
        to -= num;
      }
    }
  }

  int _delByIndex(int from, bool checkCursorOffset) {
    TextBlock text = _getByIndex(from);
    if (text != null) {
      if (text is CommonBlock) {
        text.del(1);
        return 1;
      } else {
        if (checkCursorOffset) _cursorOffset -= text.startIndex;
        _list.remove(text);
        return text.getText().length;
      }
    } else {
      throw 'invalid index';
    }
  }

  // _handleMove() {
  //   var text = _getByIndex(_cursorOffset);
  //   if (!(text is CommonBlock)) {
  //     _cursorOffset -= text.startIndex;
  //   }
  // }

  TextEditingValue _getEditingValue() {
    var now = _controller.value;

    return TextEditingValue(
      text: this.text,
      selection: TextSelection(
        baseOffset: _cursorOffset,
        extentOffset: _cursorOffset,
        affinity: now.selection.affinity,
        isDirectional: now.selection.isDirectional,
      ),
      composing: now.composing,
    );
  }

  // _debug() {
  //   var value = _getEditingValue();
  //   print("new text:${value.text} offset:${value.selection.baseOffset}");
  //   value = _controller.value;
  //   print("old text:${value.text} offset:${value.selection.baseOffset}");
  // }
}