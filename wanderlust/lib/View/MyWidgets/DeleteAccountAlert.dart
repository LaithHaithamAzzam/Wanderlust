import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/DeleteAccount.dart';
import 'package:wanderlust/Provider/WalletProvider.dart';

DeleteAccountAlert(BuildContext context)  {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context
        ){
      return WillPopScope(

        onWillPop:  () {
          return Future(() => true);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          alignment: Alignment.center,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)
                ),
                child:   Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text("rmaccount".tr,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
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
                          child:  Text("Yes Remove Account".tr,
                              style: TextStyle(color: Colors.white)),
                          onPressed: ()async {
                            await   DeletAccount(context).deletAccount();
                            Provider.of<WalletProvider>(context,listen: false).setMount(0);
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                              shadowColor: const MaterialStatePropertyAll(Color(0xffffffff)),
                              backgroundColor:
                              const MaterialStatePropertyAll(Color(0xff2da6c0)),
                              minimumSize: MaterialStatePropertyAll(
                                  Size(MediaQuery.of(context).size.width / 4, 50))),
                          child:  Text('cansle'.tr,
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                         context.pop();
                         context.pop();
                          },
                        )
                      ],
                    ),
                  ],
                )

            ),
          ),
        ),
      );

    },
  );
}