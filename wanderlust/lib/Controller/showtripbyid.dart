import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Models/Showtrip_Model.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import '../Provider/Activitys_Edite_Provider.dart';
import '../Provider/Services_Edite_Provider.dart';
import '../Provider/trip_Provider.dart';
import '../View/Admin/Trip_det_Admin.dart';
import '../View/User/Details/Trip_Detail.dart';
import 'Api.dart' as apis;

class ShowTrip {
  ShowTrip(this.context);
  BuildContext context;
  Dio dio = Dio();
  CancelToken canseltoken = CancelToken();
  String myurl = "${apis.Server_Url}""${apis.ExpandTrip}";
  ShowsTrip(int tripid,IsAdmin,index) async {

      loding(context, canseltoken);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Token = prefs.getString("Token");
      var response = await dio.post(myurl , cancelToken: canseltoken,
          options: Options(headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $Token' // token
          }),
         data: {
           "trip_id":tripid
         }
         );

      if(response.statusCode==200){

        trip_Model trip_Mode = trip_Model.fromJson(response.data);

        Navigator.of(context).pop();

          Provider.of<Trips_Provider>(context , listen:false).settrip(
              trip_Mode.trip!.tripId,
              trip_Mode.trip!.photo,
              trip_Mode.type,
              trip_Mode.trip!.season,
              trip_Mode.trip!.tripName,
              trip_Mode.trip!.pricePerPerson,
              trip_Mode.trip!.startDate,
              trip_Mode.trip!.endDate,
              trip_Mode.trip!.daysCount,
              trip_Mode.trip!.bookingEndDate,
              trip_Mode.trip!.services,
              trip_Mode.trip!.activities,
              trip_Mode.isbooking,
              trip_Mode.personCount,
              response.data['isFavourite']==null?false: response.data['isFavourite']
          );

        if(IsAdmin==true){

          Provider.of<Activitys_Edite_Provider>(context , listen: false).clear();
          Provider.of<Services_Edite_Provider>(context , listen: false).clear();

          for(int i = 0 ; i<trip_Mode.trip!.activities!.length  ; i++ ){
            Provider.of<Activitys_Edite_Provider>(context , listen: false).addNewActivity();
            Provider.of<Activitys_Edite_Provider>(context , listen: false).addNewActivitys(i, trip_Mode.trip!.activities![i].activity);
          }


          for(int i = 0 ; i<trip_Mode.trip!.services!.length  ; i++ ){
            Provider.of<Services_Edite_Provider>(context , listen: false).addNewServicess();
            Provider.of<Services_Edite_Provider>(context , listen: false).addNewServices(i, trip_Mode.trip!.services![i].service);
          }

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Trip_Details_Admin(heroindex: index,),));
        }   else{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Trip_Details(heroindex: index,),));
        }

         }else if(response.statusCode==210){

        Navigator.of(context).pop();



        }else{

      }
    } catch (e) {
      Navigator.of(context).pop();
      if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Charge  to ","API Not Sends".tr,Colors.redAccent,Colors.green,false);
}
    }
  }
}