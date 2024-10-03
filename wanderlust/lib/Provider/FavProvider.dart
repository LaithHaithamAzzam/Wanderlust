import 'package:flutter/cupertino.dart';

import '../Models/Fav_Model.dart';

class Fav_provider extends ChangeNotifier{
  List<Favourites>? favourites;

  SetFavFromAPI( List<Favourites> fav){
    favourites = fav;
    notifyListeners();
  }
  clear(){
    favourites = null;
    notifyListeners();
  }
}