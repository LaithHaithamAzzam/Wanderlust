import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/Controller/LogoutAPI.dart';
import 'package:wanderlust/View/MyWidgets/DeleteAccountAlert.dart';

import '../../Controller/DeleteAccount.dart';




Future<void> Logoutalert(BuildContext context) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) =>
          WillPopScope(
            onWillPop:  () => Future.value(true),
            child: AlertDialog(
              insetPadding: EdgeInsets.all(20.0),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              content:Container(
                width: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height/2,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.width/2,
                      child:  Image.asset(fit: BoxFit.cover,"assets/images/corruct.gif"),
                    ),
                    Expanded(child: Center(child: Text(style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),textAlign: TextAlign.center,
                        "Select Log out Or Clear Account".tr
                    )))
                  ],
                ),
              ),
              actions: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    TextButton(
                      style: ButtonStyle(

                          shadowColor: const MaterialStatePropertyAll(Color(0xffffffff)),
                          backgroundColor:
                          const MaterialStatePropertyAll(Color(0xffCB6060)),
                          minimumSize: MaterialStatePropertyAll(
                              Size(MediaQuery.of(context).size.width / 4, 50))),
                      child:  Text('Remove Account'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        DeleteAccountAlert(context);
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                          shadowColor: const MaterialStatePropertyAll(Color(0xffffffff)),
                          backgroundColor:
                          const MaterialStatePropertyAll(Color(0xff2da6c0)),
                          minimumSize: MaterialStatePropertyAll(
                              Size(MediaQuery.of(context).size.width / 4, 50))),
                      child:  Text('Logout'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                         await Logout(context).logout();
                      },
                    )
                  ],
                )

              ],
            ),
          )
  );
}
