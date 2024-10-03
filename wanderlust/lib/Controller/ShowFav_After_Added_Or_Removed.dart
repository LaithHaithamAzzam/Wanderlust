import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Models/Fav_Model.dart';
import 'package:wanderlust/Models/showtrip.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/User/Details/TypeDetail.dart';

import '../Provider/AllTrips_Provider.dart';
import '../Provider/FavProvider.dart';
import 'Api.dart' as apis;

class ShowAllFavafter {
  ShowAllFavafter(this.context);
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.GetFavourite}";

  showFavafter (bool Isadd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    try {
      var response = await dio.get(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $Token' // token
        }),
      );
      if(response.data[0]!="Favourite list empty"){
        Fav_Model fav_model = Fav_Model.fromJson(response.data);
        Provider.of<Fav_provider>(context , listen: false).SetFavFromAPI(fav_model.favourites!);


      }else {

        Provider.of<Fav_provider>(context , listen:false).clear();


      }
    } catch (e) {
if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Charge  to ","API Not Send".tr,Colors.redAccent,Colors.green,false);
}
    }
  }
}