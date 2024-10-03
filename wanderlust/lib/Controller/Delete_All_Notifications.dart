import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/ShowTripAfterDeleted.dart';
import 'package:wanderlust/Provider/Notifications_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import 'Api.dart' as apis;

class DeleteAllNotifications {

  DeleteAllNotifications(this.context);
  BuildContext context;
  Dio dio = Dio();
  deletenotifi() async {
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.DeleteNotifications}";
    try {
      var response = await dio.get(cancelToken: canseltoken,myurl,
          options: Options(headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $Token' //add token
          }),
      );
      if(response.statusCode==200) {
        Provider.of<Notifications_Provider>(context , listen:false).clear();
        context.pop();
      }
    } catch (e) {
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Rated trip","Error Clear Notifications".tr,Colors.redAccent,Colors.redAccent,false);
      }
      Navigator.of(context).pop();

    }
  }
}