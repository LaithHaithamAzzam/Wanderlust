import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/MyWallet.dart';
import 'package:wanderlust/Models/showtrip.dart';
import 'package:wanderlust/View/Admin/Trip_Menu.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';

import '../Provider/AllTrips_Provider.dart';
import 'Api.dart' as apis;

class ShowAllTrips {
  ShowAllTrips(this.context,this.Isadmn,this.addvoid);
 bool Isadmn;
 bool addvoid;
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.ShowTrips}";
  ShowTrips(bool Navigat) async {
    if(addvoid==false){
      loding(context, canseltoken);
    }
    try {
      var response = await dio.get(cancelToken: canseltoken,myurl,
          options: Options(headers: {
            'accept': 'application/json',
          }),

      );
      if(response.data[0]!="No trips found"){
        ShowAllTrips_Model showalltrip = ShowAllTrips_Model.fromJson(response.data);

          Provider.of<AllTrips_Provider>(context , listen:false).setdata(showalltrip.data);

        if(Navigat == true){
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Trip_Menu(IsAdmin:Isadmn ,)));
        }

         }else {

        // Provider.of<AllTrips_Provider>(context , listen:false).clear();
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Trip_Menu(IsAdmin:Isadmn ,)));


        }
    } catch (e) {

      Navigator.of(context).pop();
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Charge  to ","API Not Send".tr,Colors.redAccent,Colors.green,false);
}
    }
  }
}