import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/ShowAllTrips_API.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'Api.dart' as apis;


class EdittripApi{
  BuildContext context;
  EdittripApi(this.context);
  EditeTrip(
      String id,
      String type ,
      String Season_Type ,
      String Name_trip,
      Sallary,
      String Start_date,
      String  End_date,
      Day_count,
      String End_date_booking,
      List<String> Activitys,
      List<String> Services,
      )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = await prefs.getString('Token');
    CancelToken canseltoken = CancelToken();


    if(
    type.isNotEmpty &&
        Season_Type.isNotEmpty &&
        Name_trip.isNotEmpty &&
        Sallary.isNotEmpty &&
        Day_count.isNotEmpty &&
        Activitys.isNotEmpty &&
        Services.isNotEmpty
    ){

      try {

        Map<String, dynamic> tripData = {
          "id":int.parse(id),
          "type_id": type,
          "season": Season_Type,
          "trip_name": Name_trip,
          "price_per_person": Sallary,
          "start_date": Start_date,
          "end_date": End_date,
          "days_count": Day_count,
          "booking_end_date": End_date_booking,
          "activities": Activitys,
          "services": Services,
        };

        loding(context, canseltoken);

        var Res = await Dio().post(
          "${apis.Server_Url}${apis.EditTrip}",
          options: Options(
            headers: {
              'accept': 'application/json',
              'authorization': 'Bearer $Token',
            },
          ),
          data: tripData,
        );
        if (Res.statusCode == 200) {

          await  ShowAllTrips(context,true,true).ShowTrips(false);
          context.pop();
          showSnackBar(context, "Edite Trip successfully".tr, Colors.green, false);
        } else if (Res.statusCode == 210) {
          Navigator.of(context).pop();
          showSnackBar(context, "Error Edite Trip".tr, Colors.redAccent, false);
        } else {
          Navigator.of(context).pop();
        }
      } catch (e) {
        Navigator.of(context).pop();
      }
    }
    else{
      showSnackBar(context, "Not Allow Null Value".tr,
          Colors.redAccent, false);

    }

  }
}