import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import 'Api.dart' as apis;

class Logout {

  Logout(this.context);
  BuildContext context;
  Dio dio = Dio();
  logout() async {
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.logoutAPI}";
    try {
      var response = await dio.get(cancelToken: canseltoken,myurl,
          options: Options(headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $Token' //add token
          }),
      );
      if(response.statusCode==200) {
        context.go('/login');
        await prefs.clear();
      }
    } catch (e) {
if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Rated","Error Logout Please Try Again".tr,Colors.redAccent,Colors.redAccent,false);
      }
      Navigator.of(context).pop();

    }
  }
}