import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wanderlust/Controller/Change_Name_Username.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';

Future<void> RenameDialog(BuildContext context , String name , String Username) async {
  TextEditingController renewpass = TextEditingController();
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
                height:  MediaQuery.of(context).size.height/3,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      width: MediaQuery.of(context).size.width,
                      child:  Center(child: Text(style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),textAlign: TextAlign.center,
                          "Change Your Profile Name & Username".tr
                      )),
                    ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                            child: textFieldCustom(
                                obscureText: true,
                                controler: renewpass,
                                labelText: "Password".tr),
                          ),
                        ],
                      ),
                    ))
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
                          MaterialStatePropertyAll(Theme.of(context).primaryColor),
                          minimumSize: MaterialStatePropertyAll(
                              Size(MediaQuery.of(context).size.width / 4, 50))),
                      child:  Text('Save'.tr,
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                       await RenameAPI(context).RenameFunction(name, Username, renewpass.text);
                      },
                    )
                  ],
                )

              ],
            ),
          )
  );
}

