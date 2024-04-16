
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';
import 'package:travel/provider/bottom_nav_provider.dart';

import '../../Models/Social.dart';
import '../home/home.dart';
import '../profile/profile.dart';


class BottomNav extends StatelessWidget{
  
  Widget build(BuildContext context){
    var provider =Provider.of<BottomNavProvider>(context,listen: false);
    int value=0;
  List pages=[const Homepage(),Social(),Profile()];
    return Scaffold(

      body:Consumer<BottomNavProvider>(
        builder: (context, value, child) =>
          pages[value.selectedIndex]
        ,
      ),


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
        provider.changeIndex(index);
      },
    ),
    );
  }
}