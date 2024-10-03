import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as getts;


import 'package:shared_preferences/shared_preferences.dart';


import 'Api.dart' as apis;

class Delete_Trip_Date {

  Delete_Trip_Date(this.context);
  BuildContext context;
  Dio dio = Dio();
  DeleteTrip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.ExpiryDelete}";
    try {
      FormData formdata = FormData.fromMap({
        "end_date" : DateTime.now()
      });
      var response = await dio.post(myurl,
        options: Options(headers: {
          'accept': 'application/json',
           'authorization': 'Bearer $Token' // token
        }),
        data: formdata
      );
      if(response.statusCode==200) {

      }else{

      }
    } catch (e) {

    }
  }
}