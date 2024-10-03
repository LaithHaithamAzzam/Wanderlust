import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/main.dart';

import '../../locale/local_controller.dart';

class Language extends StatefulWidget {
   Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  int? selectiongrp ;
  localeController lc = Get.find();
@override
  void initState() {
  if (lang!.getString("lang") == null) {
    setState(() {
      String x = Get.deviceLocale.toString();
      lang!.setString("lang", "en");
      selectiongrp = 0;

    });
  }
  if (lang!.getString("lang")!.contains("ar")) {
    selectiongrp = 1;
  } else {
    selectiongrp = 0;
  }

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Select Language".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RadioListTile(
                    secondary: Text("الإنجليزية",style: TextStyle(color: Theme.of(context).primaryColor),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                    title: Center(child: Text("English")),
                    value: 0,
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: selectiongrp,
                    onChanged: (int? value) {
                      setState(() {
                        if (lang!.getString("lang") == null) {
                          setState(() {

                            lang!.setString("lang", "en");
                            lc.changelang("en");

                          });
                        }
                        if (lang!.getString("lang")!.contains("ar")) {
                          setState(() {
                            lc.changelang("en");

                          });
                        } else if (lang!.getString("lang")!.contains("en")) {
                          setState(() {

                            lc.changelang("ar");
                          });

                        }
                        selectiongrp = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RadioListTile(
                    secondary: Text("Arabic",style: TextStyle(color: Theme.of(context).primaryColor),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                    title: Center(child: Text("العربية")),
                    value: 1,
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: selectiongrp,
                    onChanged: (int? value) {
                      setState(() {
                        if (lang!.getString("lang") == null) {
                          setState(() {
                            String x = Get.deviceLocale.toString();
                            lang!.setString("lang", "en");


                          });
                        }
                        if (lang!.getString("lang")!.contains("ar")) {
                          setState(() {
                            lc.changelang("en");

                          });
                        } else if (lang!.getString("lang")!.contains("en")) {
                          setState(() {

                            lc.changelang("ar");
                          });

                        }
                        selectiongrp = value!;
                      });
                    },
                  ),
                ),

                MaterialButtonCustom(
                  Textcolor: Colors.white,
                  materialtext: 'Next'.tr,
                  onpressed: () async {
                    context.go("/SplashScreen1");
                  },
                  color:  Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
