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
                    child: const Text("Add 😁"),
                    onPressed: () {
                      _richInput.addText("😁");
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
                        value: " #888999 ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                      _richInput.addBlock(at);
                    },
                  ),
                  RaisedButton(
                    child: const Text("Del"),
                    onPressed: () {
                      _richInput.delText(_richInput.text.length - 3, 1);
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
