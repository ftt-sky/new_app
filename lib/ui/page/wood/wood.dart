import 'package:flutter/material.dart';

class WoodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WoodPageState();
  }
}

class WoodPageState extends State<WoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('wood'),
        ),
        body: Center(
          child: Text('wood'),
        ));
  }
}
