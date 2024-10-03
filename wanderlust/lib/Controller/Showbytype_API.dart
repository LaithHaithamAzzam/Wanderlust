import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Models/showtrip.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/User/Details/TypeDetail.dart';

import '../Provider/AllTrips_Provider.dart';
import 'Api.dart' as apis;

class ShowByType {
  ShowByType(this.context);
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.ShowType}";
  ShowTrips(type) async {

      loding(context, canseltoken);


    try {
      var response = await dio.post(cancelToken: canseltoken,myurl,
        options: Options(headers: {
          'accept': 'application/json',
        }),
        data: {
        "type":type.toString()
        }
      );
      if(response.data[0]!="No trips found"){
        ShowAllTrips_Model showalltrip = ShowAllTrips_Model.fromJson(response.data);

        Provider.of<AllTrips_Provider>(context , listen:false).setdata(showalltrip.data);


          Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            TypeDetail(Title: "$type".tr,),));


      }else {

        Provider.of<AllTrips_Provider>(context , listen:false).clear();
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            TypeDetail(Title: "$type".tr,),));


      }
    } catch (e) {

      Navigator.of(context).pop();
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Charge  to ","API Not Send".tr,Colors.redAccent,Colors.green,false);
}
    }
  }
}