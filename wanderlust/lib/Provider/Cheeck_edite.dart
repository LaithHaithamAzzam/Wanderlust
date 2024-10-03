import 'package:flutter/cupertino.dart';

class CheeckEdite extends ChangeNotifier{
  bool cheek = false;
  edite(bool chk){
    cheek = chk;
    notifyListeners();
  }
  edites(bool chk){
    cheek = chk;
  }
}