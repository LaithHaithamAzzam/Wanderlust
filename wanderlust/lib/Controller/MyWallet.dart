
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import '../Models/Mywallet_Model.dart';
import 'Api.dart' as apis;

class MywalletAPI {
  MywalletAPI(this.context);
  BuildContext context;
  Dio dio = Dio();
  String myurl = "${apis.Server_Url}""${apis.GetWallet}";
  showWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    try {
      var response = await dio.get(myurl,
          options: Options(headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $Token' // token
          }),

      );
      if(response.statusCode==200){
        MyWallet_Model mwm = MyWallet_Model.fromJson(response.data);
        Provider.of<WalletProvider>(context,listen: false).setMount(mwm.Money!);
      }else{
      }
    } catch (e) {
      Provider.of<WalletProvider>(context,listen: false).setMount(0);
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Charge  to".tr,"API Not Send".tr,Colors.redAccent,Colors.green,false);
}
    }
  }
}