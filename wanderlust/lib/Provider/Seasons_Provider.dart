import 'package:flutter/cupertino.dart';

class Seasons_Provider extends ChangeNotifier{
  String item = "Winter";
  SetValue(String val){
    item = val;
    notifyListeners();
  }
}