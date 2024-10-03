import 'package:flutter/cupertino.dart';
import 'package:wanderlust/Models/showtrip.dart';

class AllTrips_Provider extends ChangeNotifier{
  List<Data>? data;

  setdata(List<Data>? Data){
    data = Data;
    notifyListeners();
  }
  clear(){
    data = null;
    notifyListeners();
  }
}