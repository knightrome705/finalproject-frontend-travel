
import 'package:flutter/material.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/home.dart';
import 'package:travel/login.dart';
import 'package:travel/sigin.dart';
import 'package:travel/profile.dart';
import 'package:travel/splashscreen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState(){
    return MyAppState();
  }
}
class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true
    ),
      home:SplashScreen(),
    );
  }
}