import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/Image_Trip_APi.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'Api.dart' as apis;


class AddNewTrip{
  BuildContext context;
  AddNewTrip(this.context);
  addNewTrip(
      String type ,
      String Season_Type ,
      String Name_trip,
      Sallary,
      DateTime Start_date,
      DateTime  End_date,
      Day_count,
      DateTime End_date_booking,
      List<String> Activitys,
      List<String> Services,
      File? Images
      )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = await prefs.getString('Token');
    CancelToken canseltoken = CancelToken();


    if(
    type.isNotEmpty &&
    Season_Type .isNotEmpty &&
    Name_trip.isNotEmpty &&
    Sallary.isNotEmpty &&
    Day_count.isNotEmpty &&
    Activitys.isNotEmpty &&
    Services.isNotEmpty&&
    Images!.path !="null"
    ){

      try {
        String startDate = "${Start_date.year}/${Start_date.month}/${Start_date.day}";
        startDate = startDate.replaceAll("00:00:00.000", "").replaceAll("/", "-");

        String endDate = "${End_date.year}/${End_date.month}/${End_date.day}";
        endDate = endDate.replaceAll("00:00:00.000", "").replaceAll("/", "-");

        String endDateBooking = "${End_date_booking.year}/${End_date_booking.month}/${End_date_booking.day}";
        endDateBooking = endDateBooking.replaceAll("00:00:00.000", "").replaceAll("/", "-");

        Map<String, dynamic> tripData = {
          "type": type,
          "Season_Type": Season_Type,
          "Name_trip": Name_trip,
          "Sallary": Sallary,
          "Start_date": startDate,
          "End_date": endDate,
          "Day_count": Day_count,
          "End_date_booking": endDateBooking,
          "Activitys": Activitys,
          "Services": Services,
        };

        loding(context, canseltoken);

        var Res = await Dio().post(
          "${apis.Server_Url}${apis.CreateTrip}",
          options: Options(
            headers: {
              'accept': 'application/json',
              'authorization': 'Bearer $Token',
            },
          ),
          data: tripData,
        );
        if (Res.statusCode == 200) {
          await  AddPhotoAPIS(context).AddPhotoAPI(int.parse((Res.data['id']).toString()), Images , false);

        } else if (Res.statusCode == 210) {
          Navigator.of(context).pop();
          showSnackBar(context, "Error".tr, Colors.redAccent, false);
        } else {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if(e.toString().contains("[request cancelled") != true) {
        Navigator.of(context).pop();
        }
      }
    }
    else{
      showSnackBar(context, "Not Allow Null Value".tr,
          Colors.redAccent, false);
    }

  }
}