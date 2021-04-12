import 'package:flutter/material.dart';
import 'package:new_app/ui/rootpage/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "APP",
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        theme: ThemeData(
            accentColor: Colors.white,
            accentTextTheme:
                TextTheme(bodyText1: TextStyle(color: Colors.amber))),
        home: SlashPage());
  }
}
