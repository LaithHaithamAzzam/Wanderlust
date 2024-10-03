import 'package:flutter/cupertino.dart';

class TypeTrip_Provider extends ChangeNotifier{
  String item = "Beaches";
  SetValue(String val){
    item = val;
    notifyListeners();
  }
}