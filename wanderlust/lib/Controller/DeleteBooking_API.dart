import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/CheeckMyWallet.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/MyWallet.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/Wallet/DoneBooking.dart';
import '../Provider/trip_Provider.dart';
import '../View/MyWidgets/Loading_Dialog.dart';
import 'Api.dart' as apis;

class DeletebookingApi {
  DeletebookingApi(this.context);

  BuildContext context;
  Dio dio = Dio();

  Deletebooking(int trip_id) async {
    CancelToken canseltoken = CancelToken();

    loding(context , canseltoken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = prefs.getString("Token");
    String myurl = "${apis.Server_Url}""${apis.unbook}";
    try {
      var response = await dio.post(myurl,cancelToken: canseltoken,
          options: Options(headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $Token' //add token
          }),
          data: {
            "trip_id":trip_id,
          }
      );
      if(response.statusCode == 200){
        await MywalletAPI(context).showWallet();
        await Notifications_API(context).ShowNotifications(true);
        Provider.of<Trips_Provider>(context , listen: false).setIsbook(false);
        Navigator.of(context).pop();
        Showsnack(context,"Done Delete Booking".tr,"Done Delete Booking".tr,Colors.green,Colors.green,true);

      }else  if(response.statusCode == 210){
        Showsnack(context,"Too late to cancel booking".tr,"Too late to cancel booking".tr,Colors.redAccent,Colors.redAccent,true);
        Navigator.of(context).pop();
         }
    } catch (e) {
      Navigator.of(context).pop();
     if(e.toString().contains("[request cancelled") != true) {
      Showsnack(context,"Done Add Admin".tr,"Error Bookings".tr,Colors.redAccent,Colors.redAccent,false);
}
    }
  }
}