import 'dart:ui' as ui hide TextStyle;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RichEditableText extends EditableText {
  final TextSpan Function(TextEditingValue, TextStyle) richTextBuilder;
  RichEditableText({
    Key key,
    @required TextEditingController controller,
    @required FocusNode focusNode,
    bool readOnly = false,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    @required TextStyle style,
    StrutStyle strutStyle,
    @required Color cursorColor,
    @required Color backgroundCursorColor,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection,
    Locale locale,
    double textScaleFactor,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    bool forceLine = true,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
    bool autofocus = false,
    bool showCursor,
    bool showSelectionHandles = false,
    Color selectionColor,
    TextSelectionControls selectionControls,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    void Function(String) onChanged,
    void Function() onEditingComplete,
    void Function(String) onSubmitted,
    void Function(TextSelection, SelectionChangedCause) onSelectionChanged,
    void Function() onSelectionHandleTapped,
    List<TextInputFormatter> inputFormatters,
    bool rendererIgnoresPointer = false,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    bool cursorOpacityAnimates = false,
    Offset cursorOffset,
    bool paintCursorAboveText = false,
    BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    Brightness keyboardAppearance = Brightness.light,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    ScrollController scrollController,
    ScrollPhysics scrollPhysics,
    ToolbarOptions toolbarOptions = const ToolbarOptions(
      copy: true,
      cut: true,
      paste: true,
      selectAll: true,
    ),
    this.richTextBuilder,
  }) : super(
          key: key,
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          obscureText: obscureText,
          autocorrect: autocorrect,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          enableSuggestions: enableSuggestions,
          style: style,
          strutStyle: strutStyle,
          cursorColor: cursorColor,
          backgroundCursorColor: backgroundCursorColor,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          forceLine: forceLine,
          textWidthBasis: textWidthBasis,
          autofocus: autofocus,
          showCursor: showCursor,
          showSelectionHandles: showSelectionHandles,
          selectionColor: selectionColor,
          selectionControls: selectionControls,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          onSelectionChanged: onSelectionChanged,
          onSelectionHandleTapped: onSelectionHandleTapped,
          inputFormatters: inputFormatters,
          rendererIgnoresPointer: rendererIgnoresPointer,
          cursorWidth: cursorWidth,
          cursorRadius: cursorRadius,
          cursorOpacityAnimates: cursorOpacityAnimates,
          cursorOffset: cursorOffset,
          paintCursorAboveText: paintCursorAboveText,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          scrollPadding: scrollPadding,
          keyboardAppearance: keyboardAppearance,
          dragStartBehavior: dragStartBehavior,
          enableInteractiveSelection: enableInteractiveSelection,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          toolbarOptions: toolbarOptions,
        );

  @override
  createState() => _RichEditableTextState();
}

class _RichEditableTextState extends EditableTextState {
  @override
  RichEditableText get widget => super.widget;

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing = false}) {
    final TextEditingValue value = textEditingValue;
    if (widget.richTextBuilder != null) {
      return widget.richTextBuilder(value, style);
    }
    final String text = value.text;

    if (!value.composing.isValid || !withComposing) {
      return TextSpan(style: style, text: text);
    }
    final TextStyle composingStyle = style.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );
    return TextSpan(style: style, children: <TextSpan>[
      TextSpan(text: value.composing.textBefore(value.text)),
      TextSpan(
        style: composingStyle,
        text: value.composing.textInside(value.text),
      ),
      TextSpan(text: value.composing.textAfter(value.text)),
    ]);
  }
}
