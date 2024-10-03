import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';
import 'package:wanderlust/Provider/imageprofile.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'api.dart' as apis;

class CreateAccount{
  BuildContext context;
  CreateAccount(this.context);
  createAccount(String name , String userName , String password ,File? imagess)async{
    FormData formdata;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CancelToken canseltoken = CancelToken();
    try {
      loding(context , canseltoken);
      if(imagess!.path=="null"){
        formdata = FormData.fromMap({
          "username": userName,
          "password": password,
          "name": name,
        });
      }
      else{
        formdata = FormData.fromMap({
          "username": userName,
          "password": password,
          "name": name,
          "photo": await MultipartFile.fromFile(imagess!.path,),
        });
      }
      var Res = await Dio().post(cancelToken: canseltoken,"${apis.Server_Url}${apis.registerAPI}",
          options: Options(
              headers: {
                'accept': 'application/json',
              }
          ),

          data: formdata
      );
      if(Res.statusCode == 200){

        await prefs.setString("Token", "${Res.data['token']}");
        await prefs.setString("username",  "${userName.trim()}");
        await prefs.setString("name",  "${name}");
        await prefs.setString("role",  "user");
        await prefs.setString("IsLogin",  "true");
        await prefs.setString("photo", "${Res.data['photo']}");

        Provider.of<imageprofile>(context,listen: false).setImage(Res.data['photo']);
        Provider.of<WalletProvider>(context,listen: false).setUsername(userName.trim());
        Provider.of<WalletProvider>(context,listen: false).setname(name);
        Navigator.of(context).pop();
        context.go('/Home_screen');

          } else if(Res.statusCode == 210){
        Navigator.of(context).pop();
        showSnackBar(context, "The Username already exists".tr, Colors.redAccent, false);
      }else{
        Navigator.of(context).pop();
      }
    }catch (e){
      Navigator.of(context).pop();

    }

  }
}