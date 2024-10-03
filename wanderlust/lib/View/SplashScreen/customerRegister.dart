import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Register_API.dart';
import 'package:wanderlust/Provider/Imageprovider.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';
import 'package:wanderlust/Voids/Choisimage.dart';



class customerRegister extends StatefulWidget {
  const customerRegister({super.key});
  @override
  State<customerRegister> createState() => _customerRegisterState();
}

class _customerRegisterState extends State<customerRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await choisimage(context);
              },
              child: Consumer<Imageprovider>(
                builder: (context, Prov, child) {
                  return Container(
                    alignment: Alignment.center,
                      width: _w,
                      height: _w - 80,
                      color:  Prov.image != null ?Colors.transparent:Theme.of(context).primaryColor,
                      child: Prov.image != null ?
                      Image(width: _w, image: Image.file(File(Prov.image!.path),fit: BoxFit.fill,).image,):
                      Text("Your Profile Image".tr , style: TextStyle(color: Colors.white),),

                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.only(right: _w * 0.08, left: _w * 0.08),
                    child:
                        textFieldCustom(controler: name, labelText: "Your Name".tr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _w * 0.08, left: _w * 0.08),
                    child: textFieldCustom(
                        controler: username, labelText: "UserName".tr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _w * 0.08, right: _w * 0.08),
                    child: textFieldCustom(
                      obscureText: true,
                        controler: password, labelText: "Password".tr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _w * 0.08, left: _w * 0.08),
                    child: textFieldCustom(
                        obscureText: true,
                        controler: confirmpassword,
                        labelText: "Confirm Password".tr),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MaterialButtonCustom(
                        Textcolor: Colors.white,
                        materialtext: 'Create Account'.tr,
                        onpressed: () async {
                          if(name.text.isNotEmpty && username.text.trim().isNotEmpty && password.text.isNotEmpty){
                           if(password.text == confirmpassword.text){
                          if(password.text.length > 8){
                         if( Provider.of<Imageprovider>(context,listen: false).image == null){
                           await  CreateAccount(context).createAccount(
                               name.text,
                               username.text,
                               password.text
                               ,File("null"));

                         }else{
                           await  CreateAccount(context).createAccount(name.text, username.text, password.text,
                               Provider.of<Imageprovider>(context,listen: false).image
                           );
                         }
                        } else {
                        showSnackBar(context, "The password must be longer".tr, Colors.redAccent, false);
                          }
                        }else {
                             showSnackBar(context, "Your Repassword Is Not True".tr, Colors.redAccent, false);
                           }
                          }
                          else{
                            showSnackBar(context, "Not Allow Null Value".tr, Colors.redAccent, false);
                          }                          },
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                          onTap: (){
                            context.go('/login');
                          },
                          child: Text("Or Login".tr , style: TextStyle(color: Theme.of(context).primaryColor),),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
