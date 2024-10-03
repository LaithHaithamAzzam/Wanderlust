// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialButtonCustom extends StatelessWidget {

  MaterialButtonCustom(
      {
        required this.materialtext,
      required this.onpressed,
      required this.color,
        required this.Textcolor,
        this.width,
        this.height,
        this.radus,
      });
  String materialtext;
  VoidCallback onpressed;
  Color color;
  Color Textcolor;
  double? width ;
  double? height ;
  double? radus;
  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return MaterialButton(

      height: height ?? _h * 0.09,
      minWidth: width ?? _w * 0.7,
      onPressed: onpressed,
      color: color,
      shape: OutlineInputBorder(
          borderRadius: radus == null ? BorderRadius.circular(5) :BorderRadius.circular(radus!), borderSide: BorderSide.none),
      child: Text(materialtext,
          style:  TextStyle(
              color: Textcolor,fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}





class MaterialButtonCustoms extends StatelessWidget {

  MaterialButtonCustoms(
      {
        required this.materialtext,
        required this.onpressed,
        required this.color,
        required this.Textcolor,
        this.width,
        this.height,
        this.radus,
      });
  String materialtext;
  VoidCallback onpressed;
  Color color;
  Color Textcolor;
  double? width ;
  double? height ;
  double? radus;
  @override
  Widget build(BuildContext context) {

    double _w = MediaQuery.of(context).size.width;

    return MaterialButton(

      height: 50,
      minWidth: width ?? _w * 0.7,
      onPressed: onpressed,
      color: color,
      shape: OutlineInputBorder(
          borderRadius: radus == null ? BorderRadius.circular(5) :BorderRadius.circular(radus!), borderSide: BorderSide.none),
      child: Text(materialtext,
          style:  TextStyle(
              color: Textcolor,fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}

