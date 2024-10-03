import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';

import '../../Controller/Edite_Password_API.dart';

Future<void> ChangePassword(BuildContext context) async {
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
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
                height:  MediaQuery.of(context).size.height/2.5,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      width: MediaQuery.of(context).size.width,
                      child:  Center(child: Text(style: TextStyle(fontSize: 16 , color: Theme.of(context).primaryColor),textAlign: TextAlign.center,
                          "Change Your Password".tr
                      )),
                    ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                          child: textFieldCustom(
                              obscureText: true,
                              controler: oldpass,
                              labelText: "Old Password".tr),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10.0 , left: 20.0 ,bottom: 10.0 ,right: 20.0),
                          child: textFieldCustom(
                              obscureText: true,
                              controler: newpass,
                              labelText: "New Password".tr),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0 ,right: 20.0),
                          child: textFieldCustom(
                              obscureText: true,
                              controler: renewpass,
                              labelText: "Confirm New Password".tr),
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
                          if(oldpass.text.trim().isNotEmpty && newpass.text.trim().isNotEmpty && renewpass.text.trim().isNotEmpty  ){
                           if(newpass.text == renewpass.text){
                            await EditePasswordApi(context).RePasswordFunction(oldpass.text, newpass.text);
                           }
                           else{
                              showSnackBar(context, "Error Repassword".tr, Colors.redAccent, false);
                           }
                          }
                          else{
                            showSnackBar(context, "Not Allow Null Value".tr, Colors.redAccent, false);
                          }
                         context.pop();
                      },
                    )
                  ],
                )

              ],
            ),
          )
  );
}

