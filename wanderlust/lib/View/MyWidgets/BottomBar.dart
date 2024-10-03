import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/ShowAllFav_API.dart';
import 'package:wanderlust/Provider/BottomNavBar_Provider.dart';
import 'package:wanderlust/Wallet/MyWallet.dart';
import 'package:wanderlust/locale/local_controller.dart';

import '../../Provider/Cheeck_edite.dart';
import '../../main.dart';



class Bottombar extends StatefulWidget {
  @override
  BottombarState createState() => BottombarState();

}

int currentIndex = 0;

class BottombarState extends State<Bottombar> {

  @override
  Widget build(BuildContext context) {
    List<String> listOfStrings = [
      'Home'.tr,
      'Favorite'.tr,
      'Wallet'.tr,
      'Settings'.tr,
    ];

    double displayWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Consumer<BottomNavBar_Provider>(
      builder: (context, provider, child) {
        return Container(
            height: displayWidth * .155,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            ),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
              itemBuilder: (context, index) =>
                  InkWell(
                    onTap: () async {
                      currentIndex = index;
                      provider.setindex(index);
                      HapticFeedback.lightImpact();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: index == currentIndex
                                ? displayWidth * .12
                                : 0,
                            width: index == currentIndex
                                ? displayWidth * .32
                                : 0,
                            decoration: BoxDecoration(
                              color: index == currentIndex
                                  ? Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(.2)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .31
                              : displayWidth * .20,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width:
                                    index == currentIndex
                                        ? displayWidth * .10
                                        : 0,
                                  ),
                                  AnimatedOpacity(
                                    opacity: index == currentIndex ? 1 : 0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Text(
                                      index == currentIndex
                                          ? '${listOfStrings[index]}'
                                          : '',
                                      style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: displayWidth * .040,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width:
                                    index == currentIndex
                                        ? displayWidth * .02
                                        : 20,
                                  ),
                                  Icon(
                                    listOfIcons[index],
                                    size: displayWidth * .070,
                                    color: index == currentIndex
                                        ? Theme
                                        .of(context)
                                        .primaryColor
                                        : Colors.black26,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ));
      },
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_filled,
    Icons.favorite,
    Icons.wallet,
    Icons.settings_rounded,

  ];


}


