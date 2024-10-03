import 'package:flutter/cupertino.dart';

class imageprofile extends ChangeNotifier{
  String? imageprof;
  setImage(image){
    imageprof = image;
    notifyListeners();
  }
}