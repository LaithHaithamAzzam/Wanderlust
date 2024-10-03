import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'as gets;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/MyWallet.dart';
import 'package:wanderlust/Provider/imageprofile.dart';
import 'package:wanderlust/View/MyWidgets/Loading_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import '../Provider/WalletProvider.dart';
import 'Api.dart' as apis;

class Login_API{
  BuildContext context;
  Login_API(this.context);
  LoginFunction(String userName , String password)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CancelToken canseltoken = CancelToken();
    loding(context , canseltoken);
    try {
      FormData formdata = FormData.fromMap({
        "username":userName,
        "password":password,
        });
      var Res = await Dio().post(cancelToken: canseltoken,"${apis.Server_Url}${apis.loginAPI}",
          options: Options(
              headers: {
                'accept': 'application/json',
              }
          ),

          data: formdata
      );


      if(Res.statusCode == 200){

          if(kIsWeb && Res.data['role'] == "admin"){
            await prefs.setString("Token", "${Res.data['token']}");
            await prefs.setString("role",  "${Res.data['role']}");
            await prefs.setString("IsLogin",  "true");
            Navigator.of(context).pop();
            context.go("/admin");
          }else if(!kIsWeb && Res.data['role'] == "user"){
            await Notifications_API(context).ShowNotifications(true);
            Provider.of<WalletProvider>(context,listen: false).setUsername(userName.trim());
            Provider.of<WalletProvider>(context,listen: false).setname(Res.data['Name']);
            Provider.of<imageprofile>(context,listen: false).setImage(Res.data['photo']);
            await  MywalletAPI(context).showWallet();
            await prefs.setString("photo", "${Res.data['photo']}");
            Provider.of<WalletProvider>(context,listen: false).setUsername(userName.trim());
            await prefs.setString("Token", "${Res.data['token']}");
            await prefs.setString("username",  "${userName.trim()}");
            await prefs.setString("name",  "${Res.data['Name']}");
            await prefs.setString("role",  "${Res.data['role']}");
            await prefs.setString("IsLogin",  "true");
            Navigator.of(context).pop();
            context.go("/Home_screen");
          }else if(!kIsWeb && Res.data['role'] == "admin"){
            showSnackBar(context, "Only Users Can Login For Mopile", Colors.redAccent, false);
          }else if( kIsWeb && Res.data['role'] == "user"){
            showSnackBar(context, "Only Admin Can Login For Web Applications", Colors.redAccent, false);
          }


      } else if(Res.statusCode == 210){
        Navigator.of(context).pop();
        showSnackBar(context, "The User Name Already Exists", Colors.redAccent, false);
      }else{
        Navigator.of(context).pop();
      }
    }catch (e){
      Navigator.of(context).pop();
    }

  }
}