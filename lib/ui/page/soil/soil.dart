import 'package:flutter/material.dart';

class SoilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SoilPageState();
  }
}

class SoilPageState extends State<SoilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('soil'),
        ),
        body: Center(
          child: Text('soil'),
        ));
  }
}
