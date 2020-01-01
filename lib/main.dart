import 'package:flutter/material.dart';
import 'package:homework/Routs.demo.dart' as prefix0;
import 'Routs.demo.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "learn flutter",
      routes: prefix0.routes,
      initialRoute: "/",
    );
  }
}
