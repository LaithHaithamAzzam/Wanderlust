// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:wanderlust/Controller/Login_API.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(
                  "assets/images/pic4.svg",
                  width: kIsWeb? _w /4 :_w / 1.3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter your Username'.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  "And Password".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                      controler: password,
                      labelText: "Password".tr),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MaterialButtonCustom(
                      Textcolor: Colors.white,
                      materialtext: 'Login'.tr,
                      onpressed: () async {
                        if (username.text.isNotEmpty &&
                            password.text.isNotEmpty) {
                         await Login_API(context).LoginFunction(username.text, password.text);
                        } else {
                          showSnackBar(context, "Not Allow Null Value".tr,
                              Colors.redAccent, false);
                        }
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    !kIsWeb ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.go('/createaccount');
                        },
                        child: Text(
                          "Or Create Account".tr,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ):Text("")
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
