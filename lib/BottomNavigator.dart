
import 'package:flutter/material.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';
import 'package:travel/home.dart';
import 'package:travel/profile.dart';
import 'package:travel/social.dart';

class BottomNav extends StatefulWidget{
  @override
  BottomNavState createState(){
    return BottomNavState();
  }
}
class BottomNavState extends State{
  @override
  int value=0;
  List pages=[Homepage(),Social(),Profile()];
  Widget build(BuildContext context){
    return Scaffold(

      body:pages[value],


      bottomNavigationBar: SweetNavBar(
      currentIndex:value,
      items: [
        SweetNavBarItem(
            sweetActive: const Icon(Icons.home),
            sweetIcon: const Icon(
              Icons.home_outlined,
            ),
            sweetLabel: 'Home',
            sweetBackground: Colors.red),
        SweetNavBarItem(
            sweetIcon: const Icon(Icons.group), sweetLabel:'Friends'),
        SweetNavBarItem(
            sweetIcon: const Icon(Icons.account_circle), sweetLabel: 'Profile'),
      ],
      onTap: (index) {
        setState(() {
          value =index;
        });
      },
    ),
    );
  }
}