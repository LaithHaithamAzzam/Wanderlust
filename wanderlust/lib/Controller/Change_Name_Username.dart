import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/MyWallet.dart';
import 'package:wanderlust/Provider/Cheeck_edite.dart';
import 'package:wanderlust/Provider/imageprofile.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import '../Provider/WalletProvider.dart';
import 'Api.dart' as apis;

class RenameAPI{
  BuildContext context;
  RenameAPI(this.context);
  RenameFunction(String name ,String username , String password)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    try {
      Map<String, dynamic> formdata = {
        "name":name,
        "password":password,
      };
      if(username!= Provider.of<WalletProvider>(context,listen: false).Username){formdata.addAll({"username": username});}
      SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Token = await prefs.getString('Token');
      var Res = await Dio().post(cancelToken: canseltoken,"${apis.Server_Url}${apis.EditUsername}",
          options: Options(
              headers: {
                'accept': 'application/json',
                'authorization': 'Bearer $Token',
              }
          ),

          data: formdata
      );

      if(Res.statusCode == 200){

        await prefs.setString("Token", "${Res.data['new token']}");
        await prefs.setString("username",  "${username.trim()}");
        await prefs.setString("name",  "$name");


        Provider.of<WalletProvider>(context,listen: false).setUsername(username.trim());
        Provider.of<WalletProvider>(context,listen: false).setname(name);
        Provider.of<CheeckEdite>(context,listen: false).edite(false);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        
      }
      else if(Res.statusCode == 210){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showSnackBar(context, "The User Name Already Exists", Colors.redAccent, false);
      }
      else{
        Navigator.of(context).pop();
      }
    }catch (e){
     if(e.toString().contains("401")){
       Navigator.of(context).pop();
    showSnackBar(context, "Error Password", Colors.redAccent, false);
    }
      Navigator.of(context).pop();
    }

  }
}