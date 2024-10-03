import 'package:flutter/cupertino.dart';

class Services_Provider extends ChangeNotifier{

  List<String> Services = [
  ];
  addNewServices(index,data){
    Services[index]=data;
  }
  clear(){
    Services.clear();
    notifyListeners();
  }
  addNewServicess(){

    if(Services.isEmpty){
      Services.add("");
    }
    if(Services.last.trim().isNotEmpty){
      Services.add("");
    }
    notifyListeners();
  }

  clearEmpty()
  {
    Services.removeWhere((item) => item.trim().isEmpty);
    notifyListeners();
  }
}