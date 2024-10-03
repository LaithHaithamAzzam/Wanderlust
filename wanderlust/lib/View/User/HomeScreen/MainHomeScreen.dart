import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/BottomNavBar_Provider.dart';

import 'package:wanderlust/View/MyWidgets/BottomBar.dart';
import 'package:wanderlust/View/User/HomeScreen/Favorite_Screen.dart';
import 'package:wanderlust/View/User/HomeScreen/HomeScreen.dart';
import 'package:wanderlust/View/User/HomeScreen/Settings_and_Profile.dart';
import 'package:wanderlust/Voids/LayoutScreenVoids.dart';
import 'package:wanderlust/Wallet/MyWallet.dart';


class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreensSetting(context);
    return Scaffold(
          bottomNavigationBar: Bottombar(),
        body: Consumer<BottomNavBar_Provider>(
          builder: (context, provider, child) {
            if(provider.index == 0){
              return Homescreen() ;
            }else if(provider.index ==1 ){
              return FavScreen() ;
            }else if(provider.index == 2){
              return Mywallet(IsAdmin: false,) ;
            }else
            return Settings_and_Profile();
          },
        ),
    );
  }
}
