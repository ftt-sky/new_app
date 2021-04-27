import 'package:flutter/material.dart';

class FirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirdPageState();
  }
}

class FirdPageState extends State<FirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('fird'),
        ),
        body: Center(
          child: Text('fird'),
        ));
  }
}
