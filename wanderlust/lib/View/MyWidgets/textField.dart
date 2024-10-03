// ignore_for_file: file_names, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textFieldCustom extends StatelessWidget {


  // ignore: use_key_in_widget_constructors
  textFieldCustom({required this.controler, this.keyboard, this.readonly, this.paddings, required this.labelText,this.obscureText,this.onChange});
  TextEditingController controler;
  String labelText;
  TextInputType? keyboard;
  bool? obscureText;
  double? paddings;
  bool? readonly;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(paddings!=null ? paddings! : 0.0),
      child: TextFormField(
        onChanged: onChange,
        readOnly: readonly.isNull ? false : readonly!,
        obscureText: obscureText == null ?false : true,
        keyboardType: keyboard == null ? TextInputType.text :keyboard,
        controller: controler,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 10, color: Colors.black)),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}




class Textfromfild extends StatelessWidget {
   Textfromfild({this.suffixicon,this.prefixicon,required this.controllertxt,required this.hinttext,required this.txtInputType,super.key});
   Widget? suffixicon;
   Widget? prefixicon;
   TextEditingController controllertxt;
   String hinttext;
TextInputType txtInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: TextFormField(
        controller: controllertxt,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        keyboardType: txtInputType,
        decoration: InputDecoration(
          suffixIcon: suffixicon,
          prefixIcon: prefixicon,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(6))) ,enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(6))),hintText: "$hinttext",hintStyle: TextStyle(color: Colors.white60),),
      ),
    );
  }
}





class CoustoumTextfield extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  CoustoumTextfield({required this.controler,required this.type,required this.enable, required this.labelText , required this.width});
  TextEditingController controler;
  String labelText;
  double width;
  bool enable;
  TextInputType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color:Color(0xff3D36A4),
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: TextFormField(
        onChanged: (value) {
          controler.text = value;
        },
        enabled: enable,
        controller: controler,
        textAlign: TextAlign.center,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 3,
                color: Color(0xff3D36A4),
              )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 3,
                  color: Color(0xff3D36A4),
                )),
            border: InputBorder.none,
          hintText: labelText,
          hintStyle: TextStyle(color: Colors.white60)
        ),
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      ),
    );
  }
}