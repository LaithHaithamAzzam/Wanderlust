
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/Imageprovider.dart';
import 'package:wanderlust/View/Admin/Admin_Main_Screen.dart';
import 'package:wanderlust/View/SplashScreen/Language.dart';
import 'package:wanderlust/View/SplashScreen/MainSplashScreen.dart';
import 'package:wanderlust/View/SplashScreen/customerRegister.dart';
import 'package:wanderlust/View/SplashScreen/login.dart';
import 'package:wanderlust/View/SplashScreen/splashscreen1.dart';
import 'package:wanderlust/View/User/HomeScreen/MainHomeScreen.dart';
import 'package:wanderlust/Voids/LayoutScreenVoids.dart';
import 'package:wanderlust/Wallet/MyWallet.dart';



final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/lang',
      builder: (context, state) {
        return Language();

      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
      return  MainSplashScreen();

      },
    ),
    GoRoute(
      path: '/MainSplashScreen',
      builder: (context, state) {
       return  MainSplashScreen();

      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return Login();
      },
    ),
    GoRoute(
      path: '/createaccount',
      builder: (context, state) {
        Provider.of<Imageprovider>(context,listen: false).image =null;
        return customerRegister();
      },
    ),

    GoRoute(
      name: 'SplashScreen1',
      path: '/SplashScreen1',
      builder: (context, state) {
        return kIsWeb ? Login() :SplashScreen1();
      },
    ),
    GoRoute(
      name: 'Home_screen',
      path: '/Home_screen',
      builder: (context, state) {
        return MainHomeScreen();
      },
    ),  GoRoute(
      name: 'admin',
      path: '/admin',
      builder: (context, state) {

        return Admin_Main_Screen();
      },
    ),
  ],
);


void pushNamedAndRemoveUntil(String name){
  GoRouter routers= router;
  while(routers.canPop()){
    routers.pop();
  }
  routers.replaceNamed(name);
}