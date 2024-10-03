import 'package:flutter/cupertino.dart';

class Activitys_Provider extends ChangeNotifier{


  List<String> Activitys = [
  ];
  addNewActivitys(index,data){
    Activitys[index]=data;
  }
  clear(){
    Activitys.clear();
    notifyListeners();
  }
  addNewActivity(){

    if(Activitys.isEmpty){
      Activitys.add("");
    }
    if(Activitys.last.trim().isNotEmpty){
      Activitys.add("");
    }
    notifyListeners();
  }

  clearEmpty()
  {
    Activitys.removeWhere((item) => item.trim().isEmpty);
    notifyListeners();
  }
}