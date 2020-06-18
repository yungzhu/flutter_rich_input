# flutter_rich_input

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

  @override
  void initState() {
    _richInput = RichInput();
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
              _richInput.textField(),
              Wrap(
                spacing: 10,
                children: [
                  RaisedButton(
                    child: const Text("Add Text"),
                    onPressed: () {
                      _richInput.addText("text");
                    },
                  ),
                  RaisedButton(
                    child: const Text("Add ☺"),
                    onPressed: () {
                      _richInput.addText("☺");
                    },
                  ),
                  RaisedButton(
                    child: const Text("Add 👍"),
                    onPressed: () {
                      _richInput.addText("👍");
                    },
                  ),
                  RaisedButton(
                    child: const Text("Add @    "),
                    onPressed: () {
                      var at = RickBlock(text: " @abc ", value: " @123456 ");
                      _richInput.addBlock(at);
                    },
                  ),
                  RaisedButton(
                    child: const Text("Add #"),
                    onPressed: () {
                      var at = RickBlock(
                        text: " #subject ",
                        value: "#888999 ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                      _richInput.addBlock(at);
                    },
                  ),
                  RaisedButton(
                    child: const Text("Clear"),
                    onPressed: () {
                      _richInput.clear();
                    },
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
