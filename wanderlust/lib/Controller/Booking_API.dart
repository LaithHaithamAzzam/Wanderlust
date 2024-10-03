import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/CheeckMyWallet.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/MyWallet.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/Wallet/DoneBooking.dart';
import '../View/MyWidgets/Loading_Dialog.dart';
import 'Api.dart' as apis;

class Booking {
  Booking(this.context);

  BuildContext context;
  Dio dio = Dio();

  Booking_API(String trip_id, int userCount) async {
    CancelToken canseltoken = CancelToken();

      loding(context , canseltoken);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String myurl = "${apis.Server_Url}""${apis.Booking}";

      try {
        String? Token = prefs.getString("Token");

        var response = await dio.post(myurl,cancelToken: canseltoken,
            options: Options(headers: {
              'accept': 'application/json',
              'authorization': 'Bearer $Token' //add token
            }),
            data: {
              "trip_id":trip_id,
              "person_count":int.parse(userCount.toString()),
            }
        );
        if(response.statusCode == 200){

         await Notifications_API(context).ShowNotifications(true);
          await MywalletAPI(context).showWallet();
         Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoneBooking(Booking: true,),));
        }else  if(response.statusCode == 210){
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoneBooking(Booking: false,),));

          }
      } catch (e) {

        Navigator.of(context).pop();
        if(e.toString().contains("[request cancelled") != true) {
        Showsnack(context,"Done Add Admin ","Error Bookings".tr,Colors.redAccent,Colors.redAccent,false);
}
    }
  }
}