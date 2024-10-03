import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Models/showtrip.dart';
import 'package:wanderlust/Provider/Serch_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/User/Details/TypeDetail.dart';

import '../Provider/AllTrips_Provider.dart';
import 'Api.dart' as apis;

class Serchapi {

  Serchapi(this.context);
  BuildContext context;
  Dio dio = Dio();
  SerchTrips(
  String? Startdate,
  String? Enddate,
  String? Daycount,
  String? Type,
  String? Season,
  String? price,
  String? booking_end_date,
  String? trip_name,
      ) async {
    CancelToken canseltoken = CancelToken();

    loding(context , canseltoken);

    String myurl = "${apis.Server_Url}""${apis.search}";

    Map<String, String> formdata = {};

    if(Startdate!=null){formdata.addAll({"Startdate": Startdate.toString()});}
    if(Enddate!=null){formdata.addAll({"Enddate": Enddate.toString()});}
    if(Daycount!=null){formdata.addAll({"Daycount": Daycount.toString()});}
    if(Type!=null){formdata.addAll({"Type": Type.toString()});}
    if(Season!=null){formdata.addAll({"Season": Season.toString()});}
    if(price!=null){formdata.addAll({"price": price.toString()});}
    if(booking_end_date!=null){formdata.addAll({"booking_end_date": booking_end_date.toString()});}
    if(trip_name!=null){formdata.addAll({"trip_name": trip_name.toString()});}
if(formdata.isEmpty){
  context.pop();
  context.pop();
  Showsnack(context,"Done Rated ","Not allow empty value".tr,Colors.redAccent,Colors.redAccent,false);
}
else{
  try {

    var response = await dio.post(cancelToken: canseltoken,myurl,

        options: Options(headers: {
          'accept': 'application/json',
        }),
        data: formdata
    );


    if(response.statusCode==200) {
      if(response.data != "Not found"){
        print(response.data);
        Provider.of<SerchProvider>(context , listen: false).clean();
        context.pop();
        ShowAllTrips_Model showalltrip = ShowAllTrips_Model.fromJson(response.data);
        print(showalltrip.data);
        Provider.of<AllTrips_Provider>(context , listen:false).setdata(showalltrip.data);

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TypeDetail(Title: "Search".tr,),));
      }
      else{
        Provider.of<SerchProvider>(context , listen: false).clean();
        Provider.of<AllTrips_Provider>(context , listen:false).clear();
        context.pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TypeDetail(Title: "Search".tr,),));

      }

    }else if(response.statusCode==210) {
      Provider.of<SerchProvider>(context , listen: false).clean();
      Provider.of<AllTrips_Provider>(context , listen:false).clear();
      context.pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TypeDetail(Title: "Search".tr,),));

    }

  } catch (e) {

    if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Rated ","Error".tr,Colors.redAccent,Colors.redAccent,false);
    }
    Navigator.of(context).pop();

  }
}
  }
}