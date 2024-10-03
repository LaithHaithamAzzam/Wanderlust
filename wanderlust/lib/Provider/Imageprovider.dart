import 'dart:io';
import 'package:flutter/cupertino.dart';

class Imageprovider extends ChangeNotifier{
  File? image;
  Addimage(File IMAGES){
    image = IMAGES;
    notifyListeners();
  }
}