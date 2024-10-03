import 'package:flutter/cupertino.dart';

class BottomNavBar_Provider extends ChangeNotifier{
  int index = 0;
  setindex(int ind){
    index = ind;
    notifyListeners();
  }
}