import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import '../View/MyWidgets/Loading_Dialog.dart';
import 'Api.dart' as apis;

class AddAdminAPI {
  AddAdminAPI(this.context);

  BuildContext context;
  Dio dio = Dio();

  addAdmin(String userName, String Password) async {
    CancelToken canseltoken = CancelToken();
    if (userName.isNotEmpty && Password.isNotEmpty) {
      loding(context , canseltoken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = prefs.getString("Token");
      String myurl = "${apis.Server_Url}""${apis.AdminRegister}";
      try {
        var response = await dio.post(myurl,cancelToken: canseltoken,
            options: Options(headers: {
              'accept': 'application/json',
              'authorization': 'Bearer $Token' //add token
            }),
            data: {

              "name":userName,
              "username":userName,
              "password":Password,

            }
        );
        if(response.statusCode == 200){
          Navigator.of(context).pop();
          Showsnack(context,"Done Add Admin".tr+" $userName","Error Add Admin".tr+" $userName",Colors.redAccent,Colors.green,true);
        }else  if(response.statusCode == 210){
          Navigator.of(context).pop();
          Showsnack(context,"Done Add Admin".tr+" $userName","Error Add Admin".tr+" $userName",Colors.redAccent,Colors.green,false);
        }
      } catch (e) {
        Navigator.of(context).pop();
       if(e.toString().contains("[request cancelled") != true){
         Showsnack(context,"Done Add Admin".tr+" $userName","Error Add Admin".tr+" $userName",Colors.redAccent,Colors.green,false);
       }

      }
    } else {
      Showsnack(context,"Done Add Admin".tr+" $userName","Not Allow Null Value".tr,Colors.redAccent,Colors.redAccent,false);
    }
  }
}