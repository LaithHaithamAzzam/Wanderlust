import 'package:flutter/cupertino.dart';
import '../Models/Notifications_Model.dart';

class Notifications_Provider extends ChangeNotifier{
  List<Notifications>? notifications;
  int counter = 0;

  setNotifi(  List<Notifications>? notifi){
    notifications = notifi;
    counter = notifi!.length;
    notifyListeners();
  }
  clear(){
    notifications = null;
    counter = 0;
    notifyListeners();
  }
  setcounter(count){
    counter = count;
    notifyListeners();
  }
}