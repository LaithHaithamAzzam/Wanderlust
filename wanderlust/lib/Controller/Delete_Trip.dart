import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/ShowAllTrips_API.dart';
import 'package:wanderlust/Controller/ShowTripAfterDeleted.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import 'Api.dart' as apis;

class DeleteTripAPI {

  DeleteTripAPI(this.context);
  BuildContext context;
  Dio dio = Dio();
  DeleteTripREQ(int trip_id) async {
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.DeleteTrip}";
    try {
      var response = await dio.post(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $Token' //add token
        }),
        data: {
        "trip_id" : trip_id
        }
      );
      if(response.statusCode==200) {
        await  ShowAllTripsafterdelete(context).ShowTrips();
        showSnackBar(context, "Delete Trip successfully".tr, Colors.green, false);


      }
    } catch (e) {
      if(e.toString().contains("request cancelled") != true) {
      Showsnack(context,"Done Rated trip","Error".tr,Colors.redAccent,Colors.redAccent,false);
  }
      Navigator.of(context).pop();

    }
  }
}