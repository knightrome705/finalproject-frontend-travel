import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier{
  int selectedIndex=0;
  void changeIndex(int currentIndex){
    currentIndex=selectedIndex;
    notifyListeners();
  }
}