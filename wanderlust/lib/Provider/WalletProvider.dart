import 'package:flutter/cupertino.dart';

class WalletProvider extends ChangeNotifier{
  String? Username;
  String? name;
  int? mount = 0;
  setUsername(uname){
    Username = uname;
    notifyListeners();
  }
  setname(String names){
    name = names;
    notifyListeners();
  }

  setMount(int Mount){
    mount = Mount;
    notifyListeners();
  }
}