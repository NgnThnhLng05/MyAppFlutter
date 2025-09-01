import 'package:flutter/material.dart';
import 'screen.dart';
import 'models.dart';
import 'widget.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "App Quản Lý Nhân Viên",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}