import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wanderlust/Controller/LogoutAPI.dart';
import 'package:wanderlust/View/Admin/AddAdmin.dart';
import 'package:wanderlust/View/Admin/ChargeWallet.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/Voids/LayoutScreenVoids.dart';
import 'package:wanderlust/main.dart';

import '../../Controller/ShowAllTrips_API.dart';
import '../../locale/local_controller.dart';

class Admin_Main_Screen extends StatefulWidget {
  Admin_Main_Screen({super.key});

  @override
  State<Admin_Main_Screen> createState() => _Admin_Main_ScreenState();
}

class _Admin_Main_ScreenState extends State<Admin_Main_Screen> {
  bool language = false;


  @override
  Widget build(BuildContext context) {
    ScreensSetting(context);
    localeController lc = Get.find();

    if (lang!.getString("lang") == null) {
      setState(() {
        lang!.setString("lang", "en");
        language = false;
        lc.changelang("en");
      });
    }
    if (lang!.getString("lang")!.contains("ar")) {
      language = true;
    } else {
      language = false;
    }
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Screen".tr),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
            child: Row(
              children: [
                Text(
                  "English",
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Switch(
                      trackOutlineWidth: MaterialStatePropertyAll(3),
                      value: language,
                      inactiveTrackColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Theme.of(context).primaryColor,
                      trackOutlineColor: MaterialStatePropertyAll(Colors.white),
                      onChanged: (val) {
                        if (lang!.getString("lang").toString() == "null") {
                          setState(() {

                            lang!.setString("lang", "en");
                            language = false;
                            lc.changelang("en");
                          });
                        }
                        if (lang!.getString("lang")!.contains("ar")) {
                          setState(() {
                            lc.changelang("en");
                            language = false;
                          });
                        } else if (lang!.getString("lang")!.contains("en")) {
                          setState(() {
                            language = true;
                            lc.changelang("ar");
                          });

                        }
                      }),
                ),
                Text(
                  "العربية",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MaterialButtonCustom(
                  radus: 15,
                  materialtext: "Trip Menu".tr,
                  onpressed: ()async {
                  await  ShowAllTrips(context,true,false).ShowTrips(true);
                  },
                  color: Color(0xffD9D9D9),
                  width: _w - 50,
                  Textcolor: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MaterialButtonCustom(
                  radus: 15,
                  materialtext: "Charge Account".tr,
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChargeWall(),));
                    },
                  color: Color(0xffD9D9D9),
                  width: _w - 50,
                  Textcolor: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MaterialButtonCustom(
                  radus: 15,
                  materialtext: "Add Admin".tr,
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddAdmin(),));
                  },
                  color: Color(0xffD9D9D9),
                  width: _w - 50,
                  Textcolor: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: MaterialButtonCustom(
                  radus: 15,
                  materialtext: "Logout".tr,
                  onpressed: () async{
                  await  Logout(context).logout();

                  },
                  color: Colors.redAccent,
                  width: _w - 50,
                  Textcolor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
