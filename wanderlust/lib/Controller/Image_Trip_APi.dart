import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/ShowAllTrips_API.dart';
import 'package:wanderlust/Provider/trip_Provider.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'Api.dart' as apis;

class AddPhotoAPIS{
  BuildContext context;
  AddPhotoAPIS(this.context);
  AddPhotoAPI(int trip_id ,File? imagess , IsEdited )async{
    FormData formdata;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = await prefs.getString('Token');
    try {

        formdata = FormData.fromMap({
          "trip_id": trip_id,
          "photo": await MultipartFile.fromFile(imagess!.path,),

      });
      var Res = await Dio().post("${apis.Server_Url}${apis.AddPhoto}",
          options: Options(
              headers: {
                'accept': 'application/json',

          'authorization': 'Bearer $Token',
              }
          ),

          data: formdata
      );

      if(Res.statusCode == 200){


        if(IsEdited == false){
          await  ShowAllTrips(context,true,true).ShowTrips(false);
          Navigator.of(context).pop();
          Navigator.of(context).pop();


        }else{
          await  ShowAllTrips(context,true,true).ShowTrips(true);
          Provider.of<Trips_Provider>(context,listen:false).setphotopath(Res.data['photopath']);
        }

        showSnackBar(context, "Added successfully".tr, Colors.green, false);
      }
    }catch (e){

    }

  }
}