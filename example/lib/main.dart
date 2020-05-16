import 'package:flutter/material.dart';
import 'package:flutter_rich_input/block/at_block.dart';
import 'package:flutter_rich_input/flutter_rich_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RichInput rich;
  TextEditingController _controller;

  @override
  void initState() {
    rich = RichInput();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              rich.textField(
                controller: _controller,
                // style: TextStyle(color: Colors.red),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text("Add @"),
                    onPressed: () {
                      var at = AtBlock("@abc", "@123456");
                      rich.addBlock(at);
                    },
                  ),
                  RaisedButton(
                    child: Text("Add Emoji"),
                    onPressed: () {
                      rich.addText("☺");
                    },
                  ),
                  RaisedButton(
                    child: Text("Clear"),
                    onPressed: () {
                      rich.clear();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
