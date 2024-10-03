import 'package:flutter/cupertino.dart';

class SerchProvider extends ChangeNotifier{

  String season = "None";
  String type ="None";
  String? Start;
  String? End;
  String? Ebook;

  setseason(seas){
    season = seas;
    notifyListeners();
  }
  settype(types){
    type = types;
    notifyListeners();
  }
    setStart(starts){
    Start = starts;
    notifyListeners();
  }
    setEnd(ends){
    End = ends;
    notifyListeners();
  }
  setEbook(endsbook){
    Ebook = endsbook;
    notifyListeners();
  }
  clean(){
    season = "None";
    type = "None";
    Start = null;
    End = null;
    Ebook = null;
    notifyListeners();
  }
}