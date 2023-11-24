
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/Provider/booknowProvider.dart';
import 'package:travel/Provider/enquiryProvider.dart';
import 'package:travel/Provider/feedbackProvider.dart';
import 'package:travel/Provider/homeProvider.dart';
import 'package:travel/Provider/loginProvider.dart';
import 'package:travel/Provider/makeapostProvider.dart';
import 'package:travel/Provider/orderProvider.dart';
import 'package:travel/Provider/profileProvider.dart';
import 'package:travel/Provider/replyProvider.dart';
import 'package:travel/Provider/siginProvider.dart';
import 'package:travel/Provider/socialProvider.dart';
import 'package:travel/splashscreen.dart';

void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => enquiryProvider()),
      ChangeNotifierProvider(create: (context) => homeProvider(),),
      ChangeNotifierProvider(create: (context) => profileProvider(),),
      ChangeNotifierProvider(create: (context) => replyProvider(),),
      ChangeNotifierProvider(create: (context) => socialProvider(),),
      ChangeNotifierProvider(create: (context) => orderProvider(),),
      ChangeNotifierProvider(create: (context) => feedbackProvider(),),
      ChangeNotifierProvider(create: (context) => booknowProvider(),),
      ChangeNotifierProvider(create: (context) => makeaProvider(),),
      ChangeNotifierProvider(create: (context) => loginProvider(),),
      ChangeNotifierProvider(create: (context) => siginProvider(),)
    ],
      child: MyApp()));
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