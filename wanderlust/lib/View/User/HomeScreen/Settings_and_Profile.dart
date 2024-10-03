import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/EditeUserPhoto.dart';
import 'package:wanderlust/Provider/Cheeck_edite.dart';
import 'package:wanderlust/View/MyWidgets/Change_Password_Dialog.dart';
import 'package:wanderlust/View/MyWidgets/Logout_Void.dart';
import 'package:wanderlust/View/MyWidgets/RenameDialog.dart';
import 'package:wanderlust/View/MyWidgets/SnackBar.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';
import 'package:wanderlust/Voids/changeProfileImage.dart';
import 'package:wanderlust/locale/local_controller.dart';
import 'package:wanderlust/main.dart';
import '../../../Controller/Api.dart';
import '../../../Provider/WalletProvider.dart';
import '../../../Provider/imageprofile.dart';

class Settings_and_Profile extends StatefulWidget {
  Settings_and_Profile({super.key});

  @override
  State<Settings_and_Profile> createState() => _Settings_and_ProfileState();
}

class _Settings_and_ProfileState extends State<Settings_and_Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  localeController lc = Get.find();

  bool language = false;
   @override

  void initState() {
     Provider.of<CheeckEdite>(context,listen: false).edite(false);
     name.text = "${Provider.of<WalletProvider>(context,listen: false).name}";
     username.text = "${Provider.of<WalletProvider>(context,listen: false).Username}";
     if (lang!.getString("lang").toString() == "null") {
       setState(() {
         lang!.setString("lang", "en");
         lc.changelang("en");
         language = false;

       });
     }
     if (lang!.getString("lang")!.contains("en")) {
       language = false;
     } else {
       language = true;
     }
     super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0 , left: 18.0),
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
                        if (lang!.getString("lang") == null) {
                          setState(() {
                            String x = Get.deviceLocale.toString();
                            lang!.setString("lang", x);
                            language = false;

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
        leading: Consumer<CheeckEdite>(
          builder: (context, provider, child) {
          
            return provider.cheek == true
                ? IconButton(
                    onPressed: () async {
                      if (name.text.isNotEmpty &&
                          username.text.trim().isNotEmpty) {
                        RenameDialog(context,name.text,username.text);

                      } else {
                        showSnackBar(context, "Not allow empty value".tr,
                            Colors.redAccent, false);
                      }
                    },
                    icon: Icon(Icons.save))
                : IconButton(
                    onPressed: () async {
                      Logoutalert(context);
                    },
                    icon: Icon(
                      Icons.logout,
                    ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<imageprofile>(
  builder: (context, provider, child) {

  return provider.imageprof!= null ?  GestureDetector(
    onTap: ()async{
     await choisimageprof(context);
    },
    child: Container(
                alignment: Alignment.center,
                width: _w,
                height: _w / 1.3,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("$imagesurl/${provider.imageprof}"),fit: BoxFit.cover)
                ),
                child:Text(
                  "",
                ),
              ),
  ):GestureDetector(
    onTap: ()async{
      await choisimageprof(context);
    },
    child: Container(
                alignment: Alignment.center,
                width: _w,
                height: _w / 1.3,
                color: Colors.grey,
                child:Text(
                  "Your Image Profile".tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
  );
  },
),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child: Consumer<CheeckEdite>(
  builder: (context, provider, child) {
  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(right: _w * 0.08, left: _w * 0.08),
                        child: textFieldCustom(
                            onChange: (txtname){
                              name.text = txtname;
                              if(Provider.of<WalletProvider>(context,listen: false).name == txtname ) {
                                if(username.text == Provider.of<WalletProvider>(context,listen: false).Username){
                                  provider.edite(false);
                                }
                                else{
                                  if(provider.cheek == false){
                                    provider.edite(true);
                                  }else{

                                  }
                                }
                              }
                              else{
                                if(provider.cheek == false){
                                  provider.edite(true);
                                }else{

                                }
                              }
                            },
                            controler: name, labelText: "Your Name".tr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: _w * 0.08, left: _w * 0.08),
                        child: textFieldCustom(
                            onChange: (textusername){
                              username.text = textusername.trim();
                              if(Provider.of<WalletProvider>(context,listen: false).Username == textusername ) {
                                if(name.text == Provider.of<WalletProvider>(context,listen: false).name){
                                  provider.edite(false);
                                }
                                else{
                                  if(provider.cheek == false){
                                    provider.edite(true);
                                  }else{

                                  }
                                }
                              }
                              else{
                                if(provider.cheek == false){
                                  provider.edite(true);
                                }else{

                                }
                              }
                            },
                            controler: username, labelText: "UserName".tr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      MaterialButtonCustom(
                        Textcolor: Colors.white,
                        materialtext: 'Change My Password'.tr,
                        onpressed: () async {
                          ChangePassword(context);
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                    ]);
  },
),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
