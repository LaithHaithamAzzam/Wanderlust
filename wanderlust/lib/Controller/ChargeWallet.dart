import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import 'Api.dart' as apis;

class ChargeWallet {
  ChargeWallet(this.context);

  BuildContext context;
  Dio dio = Dio();

  chargeWallet(String userName, String amount) async {
    if (userName.isNotEmpty && amount.isNotEmpty) {
      CancelToken canseltoken = CancelToken();
      loding(context , canseltoken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = prefs.getString("Token");
      String myurl = "${apis.Server_Url}""${apis.charge}";
      try {
        var response = await dio.post(cancelToken: canseltoken,myurl,
            options: Options(headers: {
              'accept': 'application/json',
              'authorization': 'Bearer $Token' //add token
            }),
            data: {
              "user":userName,
              "amount":amount,
            }
        );
        if(response.statusCode==200){
          Navigator.of(context).pop();
          Showsnack(context,"Done Charge".tr+" $userName : $amount" ,"Error Charge".tr+" $userName"+"to".tr+" $amount",Colors.redAccent,Colors.green,true);
        }else if(response.statusCode==210){
          Navigator.of(context).pop();
          Showsnack(context,"Done Charge".tr+" $userName : $amount" ,"$userName ${(response.data['data'])} ",Colors.redAccent,Colors.green,false);
        }
      } catch (e) {
        Navigator.of(context).pop();
        if(e.toString().contains("[request cancelled") != true) {
        Showsnack(context,"Done Charge".tr+" $userName " +"to".tr+" $amount","ErrorCharge $userName to $amount",Colors.redAccent,Colors.green,false);
}
      }
    } else {
      Showsnack(context,"Done Add Admin".tr+" $userName","Not Allow Null Value".tr,Colors.redAccent,Colors.green,false);
    }
  }
}