import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/Delete_Trip_Date.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/ShowAllFav_API.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';
import 'package:wanderlust/Provider/imageprofile.dart';
import '../../Controller/MyWallet.dart';
import '../../Voids/LayoutScreenVoids.dart';


class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({super.key});

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  Islogin() async {


      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? IsLogin = await prefs.getString('IsLogin');
      String? rool = await prefs.getString('role');


      if(IsLogin=="true"){
        if(rool == "admin"){
          await Delete_Trip_Date(context).DeleteTrip();
          context.go("/admin");

        }else if(rool  == "user"){
          await MywalletAPI(context).showWallet();
          await ShowAllFav(context).showFav();
          await Notifications_API(context).ShowNotifications(true);
          String? photo = await prefs.getString('photo');
          String? username = await prefs.getString('username');
          String? name = await prefs.getString('name');
          Provider.of<imageprofile>(context,listen: false).setImage(photo=="null"?null:photo);
          Provider.of<WalletProvider>(context,listen: false).setUsername("$username");
          Provider.of<WalletProvider>(context,listen: false).setname("$name");
          context.go("/Home_screen");
        }

      }
      else
      {
      context.pushReplacement('/lang');
        }

  }

  @override
  Widget build(BuildContext context) {

    Islogin();
    double widthscreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  kIsWeb ? Center(
        child: Image.asset("assets/images/icon.jpg",width: widthscreen/5,),
      ):Center(
        child: Image.asset("assets/images/icon.jpg",width: widthscreen/2,),
      )
    );
  }
}
