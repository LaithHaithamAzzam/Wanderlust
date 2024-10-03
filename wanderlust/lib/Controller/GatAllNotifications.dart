import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Models/Notifications_Model.dart';
import 'package:wanderlust/Provider/Notifications_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/User/HomeScreen/Notifications.dart';
import 'Api.dart' as apis;

class Notifications_API {
  Notifications_API(this.context);
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.ShowNotifications}";
  ShowNotifications(bool issplash) async {

    if(issplash == false){
      loding(context, canseltoken);
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = prefs.getString("Token");
      var response = await dio.get(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $Token' // token
        }),

      );
      if(response.data[0]!="No notifications"){

        Notifications_Model notifications_Model = Notifications_Model.fromJson(response.data);

        Provider.of<Notifications_Provider>(context , listen:false).setNotifi(notifications_Model.notifications);

        if(issplash == false){
          Navigator.of(context).pop();
        }

      }else {

         Provider.of<Notifications_Provider>(context , listen:false).clear();
        if(issplash == false){
          Navigator.of(context).pop();
        }
      }
    } catch (e) {

      if(issplash == false){
        Navigator.of(context).pop();
      }
      Showsnack(context,"Done Charge to".tr,"API Not Send".tr,Colors.redAccent,Colors.green,false);

    }
  }
}