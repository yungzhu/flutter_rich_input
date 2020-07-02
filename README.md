# flutter_rich_input

# flutter_rich_input is no longer used and uses a better way to enable a rich_input plugin, [click here to see it!](https://pub.dev/packages/rich_input)

This is a high performance rich media input box, implemented through the native textfield extension, with less disruptive, but at the same time has a strong extensibility, implements the @ someone, # topics, expressions and other functions, support custom color highlighting

Language: [English](README.md) | [中文简体](README-ZH.md)

## Special feature

-   Use native textfield capabilities with less code, less disruption and subsequent compatibility
-   Support @someone #topic and insert emojis, etc.
-   Support for custom highlighting and even your own rendering
-   Support for custom value fields to enhance rich text

![Demo](demo.jpg)

## Getting Started

```dart
import 'package:flutter/material.dart';
import 'package:flutter_rich_input/block/rich_block.dart';
import 'package:flutter_rich_input/flutter_rich_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RichInput _richInput;
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _richInput = RichInput();
    // refresh text and value
    _richInput.controller.addListener(() {
      setState(() {});
    });
    _richInput.addText("text");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _richInput.textField(focusNode: _focusNode),
              Wrap(
                spacing: 10,
                children: [
                  RaisedButton(
                    onPressed: () {
                      _richInput.addText("text");
                    },
                    child: const Text("Add Text"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _richInput.addText("😁");
                    },
                    child: const Text("Add 😁"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _richInput.addText("👍");
                    },
                    child: const Text("Add 👍"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      final at = RichBlock(text: " @abc ", value: " @123456 ");
                      _richInput.addBlock(at);
                    },
                    child: const Text("Add @    "),
                  ),
                  RaisedButton(
                    onPressed: () {
                      final at = RichBlock(
                        text: " #subject ",
                        value: " #888999 ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                      _richInput.addBlock(at);
                    },
                    child: const Text("Add #"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _richInput.clear();
                    },
                    child: const Text("Clear"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _focusNode.unfocus();
                    },
                    child: const Text("unfocus"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text("Text:${_richInput.text}"),
              const SizedBox(height: 10),
              Text("Value:${_richInput.value}"),
            ],
          ),
        ),
      ),
    );
  }
}
```

> Provide additional api via RichInput class and interface consistent with native textfield via RichInput.textfield method
