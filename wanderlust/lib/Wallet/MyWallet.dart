import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/BottomNavBar_Provider.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';

import '../Controller/CheeckMyWallet.dart';


class Mywallet extends StatelessWidget {

   Mywallet({ required this.IsAdmin , super.key});
   bool IsAdmin;
  @override
  TextEditingController monyContr = TextEditingController(text: "50000");
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
       if(IsAdmin) {
     Navigator.of(context).pop();
        }
       else{
         if (Provider.of<BottomNavBar_Provider>(context, listen: false)
             .index ==
             2) {
           Provider.of<BottomNavBar_Provider>(context, listen: false)
               .setindex(0);
         } else {
           context.go("/Home_screen");
         }
       }
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text("My Wallet".tr , style: TextStyle(fontSize: 16),),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15.0 , right: 15.0 , top: 5),
            child: Column(
              children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 38.0 , top: 19.0),
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     SvgPicture.asset("assets/images/wallet.svg" , width: 350,),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 30.0),
                       child: Align(
                           alignment: Alignment(-0.8, 0),
                           child: Text("${Provider.of<WalletProvider>(context,listen: false).Username!.toUpperCase()}" , style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.width * 0.037),)),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 0.0),
                       child: Align(
                           alignment: Alignment(0.8, 6),
                           heightFactor: 2,
                           child: Text("${int.parse((Provider.of<WalletProvider>(context,listen: true).mount).toString())} SP" , style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.width * 0.037),))
                     ),
                   ],
                 ),
               ),
                MaterialButtonCustom(color: Color(0xffe7e7e7),
                  materialtext: "Check My Wallet".tr,
                Textcolor: Theme.of(context).primaryColor,
                width: MediaQuery.of(context).size.width - 60,
                height: 60,
                onpressed: ()async{
                 await ChhekMywalletAPI(context).showWallet();
                },
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}


