import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import 'Api.dart' as apis;

class DeletAccount {

  DeletAccount(this.context);
  BuildContext context;
  Dio dio = Dio();
  deletAccount() async {
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.DeleteUser}";
    try {
      var response = await dio.put(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $Token' //add token
        }),
      );
      if(response.statusCode==200) {
        Showsnack(context,"Done Delete Account".tr,"Done Delete Account".tr,Colors.green,Colors.green,false);

        await prefs.clear();
        context.go('/login');

      }
    } catch (e) {
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done","Error".tr,Colors.redAccent,Colors.redAccent,false);
    }  Navigator.of(context).pop();

    }
  }
}