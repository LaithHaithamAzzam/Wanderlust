import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/ShowFav_After_Added_Or_Removed.dart';
import 'package:wanderlust/Models/showtrip.dart';
import 'package:wanderlust/Provider/trip_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/User/Details/TypeDetail.dart';

import '../Provider/AllTrips_Provider.dart';
import 'Api.dart' as apis;

class AddFavAPI {
  AddFavAPI(this.context);
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.AddFavourite}";
  addFav(int trip_id) async {

    loding(context, canseltoken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = prefs.getString("Token");

    try {
      var response = await dio.post(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
           'authorization': 'Bearer $Token' // token
        }),
        data: {
        "trip_id":trip_id
        }
      );
      if(response.statusCode == 200){
        await ShowAllFavafter(context).showFavafter(true);
        Provider.of<Trips_Provider>(context,listen: false).setIsfav(true);
        context.pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      if(e.toString().contains("[request cancelled") != true) {
        Showsnack(context, "Done Charge  to".tr, "API Not Send".tr, Colors.redAccent,
            Colors.green, false);
      }
    }
  }
}