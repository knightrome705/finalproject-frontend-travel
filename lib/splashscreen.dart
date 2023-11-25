import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/BottomNavigator.dart';
import 'package:travel/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userLoginCred = pref.getBool('user_logged');
    if(userLoginCred ==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(),));
      Fluttertoast.showToast(msg: "Welcome");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      Fluttertoast.showToast(msg: "Please login");
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).whenComplete(() => checkLogin());
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Center(
        child:Lottie.asset("assests/Animation - 1700198877031.json"),
      ),
    );
  }
}
