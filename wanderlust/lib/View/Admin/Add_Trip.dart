import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/Activitys_Provider.dart';
import 'package:wanderlust/Provider/Seasons_Provider.dart';
import 'package:wanderlust/Provider/SelectDateProvider.dart';
import 'package:wanderlust/Provider/Services_Provider.dart';
import 'package:wanderlust/Provider/TypeTrip_Provider.dart';
import 'package:wanderlust/View/MyWidgets/Admin_Date.dart';
import 'package:wanderlust/View/MyWidgets/DropDownLists.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/View/MyWidgets/textField.dart';
import 'package:wanderlust/Voids/Choisimage.dart';

import '../../Controller/AddTrip.dart';
import '../../Provider/Imageprovider.dart';
import '../../Voids/End_Date_Booking_Date_Dialog.dart';

class Add_Trip extends StatelessWidget {
  Add_Trip({super.key});
  TextEditingController NameTrip = TextEditingController();
  TextEditingController Salary = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isopen = false;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Provider.of<Services_Provider>(context,listen: false).clearEmpty();
                Provider.of<Activitys_Provider>(context,listen: false).clearEmpty();

                if( Provider.of<Imageprovider>(context,listen: false).image == null){
                  await AddNewTrip(context).addNewTrip(
                      Provider.of<TypeTrip_Provider>(context , listen: false).item,
                      Provider.of<Seasons_Provider>(context , listen: false).item,
                      NameTrip.text,
                      Salary.text,
                      Provider.of<SelectDate>(context , listen: false).stardate!,
                      Provider.of<SelectDate>(context , listen: false).enddate!,
                      Provider.of<SelectDate>(context , listen: false).DayCount,
                      Provider.of<SelectDate>(context , listen: false).enddatebooking!,
                      Provider.of<Activitys_Provider>(context,listen: false).Activitys,
                      Provider.of<Services_Provider>(context,listen: false).Services,
                      File("null")
                  );

                }else{
                  await AddNewTrip(context).addNewTrip(
                      Provider.of<TypeTrip_Provider>(context , listen: false).item,
                      Provider.of<Seasons_Provider>(context , listen: false).item,
                      NameTrip.text,
                      Salary.text,
                      Provider.of<SelectDate>(context , listen: false).stardate!,
                      Provider.of<SelectDate>(context , listen: false).enddate!,
                      Provider.of<SelectDate>(context , listen: false).DayCount,
                      Provider.of<SelectDate>(context , listen: false).enddatebooking!,
                      Provider.of<Activitys_Provider>(context,listen: false).Activitys,
                      Provider.of<Services_Provider>(context,listen: false).Services,
                      Provider.of<Imageprovider>(context,listen: false).image);
                }

              },
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
        title: Text("Add New Trip".tr),
      ),
      body: SingleChildScrollView(
          controller: _scrollController,
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
                    Text("Your Trip Image".tr , style: TextStyle(color: Colors.white),),

                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),border: Border.all(color: Colors.black)),
                  child: dropdowncutom(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),border: Border.all(color: Colors.black)),
                child: Season_Type(),
              ),
            ),
            textFieldCustom(
              controler: NameTrip,
              labelText: "Name Trip".tr,
              paddings: 10.0,
            ),
            textFieldCustom(
              controler: Salary,
              labelText: "Salary Trip On One Person".tr,
              paddings: 10.0,
              keyboard: TextInputType.number,
            ),
            GestureDetector(
              onTap: () {
                Selectdate(context);
              },
             child: Container(
               decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),border: Border.all(color: Colors.black)),
               child: Column(
                 children: [
                   Consumer<SelectDate>(
                     builder: (context, provider, child) {
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 10.0),
                         child: Container(
                           alignment: Alignment.center,
                           width: _w - 20,
                           height: 60,
                           child:   provider.stardate.isNull ?  Center(child: Text("Start Date".tr)) : Center(child: Text("Start Date".tr+" : "+  provider.stardate.toString().replaceAll("00:00:00.000", ""))),
                         ),
                       );
                     },
                   ),
                   Consumer<SelectDate>(
                     builder: (context, provider, child) {
                       return Container(
                         alignment: Alignment.center,
                         width: _w - 20,
                         height: 60,
                         child:   provider.enddate.isNull ?  Center(child: Text("End Date".tr)) : Center(child: Text( "End Date".tr+" : "+  provider.enddate.toString().replaceAll("00:00:00.000", ""))),
                       );
                     },
                   ),
                   Consumer<SelectDate>(
                     builder: (context, provider, child) {
                       return Container(
                         alignment: Alignment.center,
                         width: _w - 20,
                         height: 60,
                         child:   provider.DayCount.isNull ?  Center(child: Text("Day Count".tr)) : Center(child: Text("Day Count".tr+" : "+ provider.DayCount!.toString())),
                       );
                     },
                   ),
                 ],
               ),
             ),
           ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Consumer<SelectDate>(
  builder: (context, provider, child) {
  return MaterialButtonCustom(
                width: _w-20,
                  materialtext: provider
                      .isopen == false ? "Select End Date Booking".tr :
                           "${
                               (provider.enddatebooking).toString().replaceAll("00:00:00.000", "")
                           }",
                  onpressed: () {
                    selectedatebooking(context);
                  },
                  color: Theme.of(context).primaryColor,
                  Textcolor: Colors.white);
  },
),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0 , left: 8.0 ,bottom: 8.0,right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Activitys".tr , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
                  ,IconButton(onPressed: (){
                    Provider.of<Activitys_Provider>(context,listen: false).addNewActivity();
                  }, icon: Icon(Icons.add))
                ],
              ),
            ),
            Consumer<Activitys_Provider>(
              builder: (context, provider, child) {

                if(provider.Activitys.isNotEmpty){
                  _scrollController.animateTo(_scrollController.offset*10, duration: Duration(seconds: 1), curve: Curves.easeIn,);
                }

                return Container(
                  alignment: Alignment.center,
                  width: _w,
                  height: provider.Activitys.length*65,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.all(Radius.circular(9))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0 , top: 20.0,right: 8.0),
                    child: ListView.builder(
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: provider.Activitys.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  child: Text("${index+1}" , style: TextStyle(color: Colors.white),),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(50))
                                  ),
                                ),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                  child: TextFormField(
                                    controller: TextEditingController(
                                        text: provider.Activitys[index]
                                    ),
                                    onChanged: (value) {
                                      provider.addNewActivitys(index , value);
                                    },
                                    decoration: InputDecoration.collapsed(hintText: "Activitys".tr),
                                  ),
                                ))
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                                  child:Container(
                                    color: Colors.black,
                                    width: _w-20,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0 , left: 8.0 ,bottom: 8.0,right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Services".tr , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
                  ,IconButton(onPressed: (){
                    Provider.of<Services_Provider>(context,listen: false).addNewServicess();
                  }, icon: Icon(Icons.add))
                ],
              ),
            ),
            Consumer<Services_Provider>(
              builder: (context, provider, child) {

                if(provider.Services.isNotEmpty){
                  _scrollController.animateTo(_scrollController.offset*10, duration: Duration(seconds: 1), curve: Curves.easeIn,);
                }
                return Container(
                  alignment: Alignment.center,
                  width: _w,
                  height: provider.Services.length*65,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.all(Radius.circular(9))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0 , top: 20.0,right: 8.0),
                    child: ListView.builder(
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: provider.Services.length,
                      itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                child: Text("${index+1}" , style: TextStyle(color: Colors.white),),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text: provider.Services[index]
                                  ),
                                  onChanged: (value) {
                                    provider.addNewServices(index , value);
                                  },
                                  decoration: InputDecoration.collapsed(hintText: "Services".tr),
                                ),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                                child:Container(
                                  color: Colors.black,
                                  width: _w-20,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
