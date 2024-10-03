import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/HomeImages.dart';
import 'package:wanderlust/Controller/SerchAPI.dart';
import 'package:wanderlust/Controller/ShowAllTrips_API.dart';
import 'package:wanderlust/Controller/Showbytype_API.dart';
import 'package:wanderlust/Provider/Notifications_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Serch_Dialog.dart';
import 'package:wanderlust/View/User/Details/TypeDetail.dart';
import 'package:wanderlust/View/User/HomeScreen/Notifications.dart';

import '../../../Controller/GatAllNotifications.dart';



class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;

    return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
      child: Scaffold(

        appBar: AppBar(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          actions: [
                 Consumer<Notifications_Provider>(
  builder: (context, provider, child) {


    return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(children: [
                        Hero(
                          tag: "notification-icon",
                          child: IconButton(
                            onPressed: () async {
                              provider.setcounter(0);
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications_Screen(),));
                            },
                            style: ButtonStyle(
                                minimumSize:
                                MaterialStatePropertyAll(Size(40, 40)),
                                iconColor:
                                MaterialStatePropertyAll(Colors.black),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xffEDEDED),
                                            width: 1.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))))),
                            icon: Icon(Icons.notifications , color: Colors.white,)

                          ),
                        ),
                        provider.counter ! > 0
                            ? Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${provider.counter}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))))
                            : Container(
                         width: 15,
                         height: 15,
                       ),
                      ]),
                      SearchBar(
                        trailing: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                SerchDialog(context);
                              },
                              style: ButtonStyle(
                                  iconSize: MaterialStatePropertyAll(15),
                                  minimumSize:
                                  MaterialStatePropertyAll(Size(35, 35)),
                                  maximumSize:
                                  MaterialStatePropertyAll(Size(35, 35)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).primaryColor),
                                  iconColor:
                                  MaterialStatePropertyAll(Colors.white),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))))),
                              icon: Icon(
                               Icons.filter_list_outlined,
                              ),
                            ),
                          ],
                        ).children.toList(),
                        constraints: BoxConstraints(
                            minHeight: 40,
                            maxHeight: 40,
                            maxWidth: MediaQuery.of(context).size.width / 1.3,
                            minWidth: MediaQuery.of(context).size.width / 1.3),
                        surfaceTintColor:
                        MaterialStatePropertyAll(Colors.white),
                        shadowColor:
                        MaterialStatePropertyAll(Colors.transparent),
                        hintText: "Serch".tr,
                        hintStyle: MaterialStatePropertyAll(
                            TextStyle(color: Color(0xff878787), fontSize: 16)),
                        leading: Icon(
                          Icons.search,
                          color: Color(0xff878787),
                        ),
                        overlayColor: MaterialStatePropertyAll(Colors.white),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            side: BorderSide(
                                color: Color(0xffEDEDED),
                                width: 1,
                                style: BorderStyle.solid))),
                        onSubmitted: (text)async{
                         await Serchapi(context).SerchTrips(null, null, null, null, null, null, null, text.toString());
                        },
                      )
                    ],
                  ),
                );
  },
)
          ],
        ),
        body: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
            Padding(
            padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            ShowByType(context).ShowTrips("Beaches");
          },
          child: Container(
            alignment: Alignment.center,
            width: width / 3,
            height:  width / 3,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(2.0, 4.0),
                    blurStyle: BlurStyle.normal),
                BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(2.0, 4.0),
                    blurStyle: BlurStyle.inner),
              ],
              image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[0]}"),fit: BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Text( "Beaches".tr ,style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                ShowByType(context).ShowTrips("Cities");
              },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[1]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text("Cities".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                ShowByType(context).ShowTrips("Desert");


              },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[2]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text( "Desert".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                ShowByType(context).ShowTrips("Lakes");
  },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[3]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text("Lakes".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                ShowByType(context).ShowTrips("Mountains");
                },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[4]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text( "Mountains".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async{
                ShowByType(context).ShowTrips("Tourist Attractions");
              },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[5]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text( "Tourist Attractions".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: ()async {
                await  ShowAllTrips(context,false,false).ShowTrips(true);
              },
              child: Container(
                alignment: Alignment.center,
                width: width / 3,
                height:  width / 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2.0, 4.0),
                        blurStyle: BlurStyle.inner),
                  ],
                  image: DecorationImage(colorFilter:ColorFilter.mode(Colors.black38, BlendMode.darken),image: AssetImage("${Images[6]}"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Text("Other".tr,style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ],
        )
      ),
    );
  }
}
