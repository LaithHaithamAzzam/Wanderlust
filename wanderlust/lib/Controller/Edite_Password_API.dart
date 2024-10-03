import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gets;
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'Api.dart' as apis;

class EditePasswordApi{
  BuildContext context;
  EditePasswordApi(this.context);
  RePasswordFunction(String old ,String newpass)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    try {
      FormData formdata = FormData.fromMap({
        "new_password":newpass,
        "old_password":old,
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = await prefs.getString('Token');
      var Res = await Dio().post(cancelToken: canseltoken,"${apis.Server_Url}${apis.EditPassword}",
          options: Options(
              headers: {
                'accept': 'application/json',
                'authorization': 'Bearer $Token',
              }
          ),

          data: formdata
      );

      if(Res.statusCode == 200) {
        context.pop();
        showSnackBar(context, "Change Password Succsfuly".tr, Colors.green, false);
      }else if(Res.statusCode == 210) {
        context.pop();
        showSnackBar(context, "The password must be longer".tr, Colors.redAccent, false);
      }


    }catch (e){
      if(e.toString().contains("401")){
        Navigator.of(context).pop();
        showSnackBar(context, "Error Password", Colors.redAccent, false);
      }
      Navigator.of(context).pop();

    }

  }
}