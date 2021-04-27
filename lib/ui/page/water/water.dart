import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WaterPageState();
  }
}

class WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('water'),
        ),
        body: Center(
          child: Text('water'),
        ));
  }
}
