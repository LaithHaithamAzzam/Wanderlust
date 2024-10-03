import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Api.dart';
import 'package:wanderlust/Provider/Activitys_Edite_Provider.dart';
import 'package:wanderlust/Provider/Services_Edite_Provider.dart';
import 'package:wanderlust/View/MyWidgets/EditesDialog.dart';

import '../../Controller/EditTrip_API.dart';
import '../../Provider/trip_Provider.dart';


class Trip_Details_Admin extends StatelessWidget {
  Trip_Details_Admin({required this.heroindex , super.key});
  int counter = 3;
  int heroindex;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details".tr),
        actions: [
          GestureDetector(
            onTap: ()async{
              await EdittripApi(context).EditeTrip(
                  Provider.of<Trips_Provider>(context,listen: false).tripId.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).type.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).season.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).tripName.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).pricePerPerson.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).startDate.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).endDate.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).daysCount.toString(),
                  Provider.of<Trips_Provider>(context,listen: false).bookingEndDate.toString(), Provider.of<Activitys_Edite_Provider>(context,listen: false).Activitys, Provider.of<Services_Edite_Provider>(context,listen: false).Services
                  );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0,left: 8.0),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),
      body: Consumer<Trips_Provider>(
  builder: (context, provider, child) {
  return SingleChildScrollView(
        controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      choisEditedimage(context,
                          int.parse(  Provider.of<Trips_Provider>(context,listen: false).tripId.toString()),
                      heroindex
                      );
                    },
                    child: Hero(
                      tag: "image$heroindex",
                      child: Container(
                        alignment: Alignment.center,
                        width: _w,
                        height: _w-80,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("$imagesurl/${provider.photo}"),fit: BoxFit.cover)
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: _w,

                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(9),bottomLeft: Radius.circular(9))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.swap_horizontal_circle , color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text("Type".tr+" :", style: TextStyle(fontSize: 15 , color: Colors.white)),
                              ),
                              Expanded(child: Editedropdowncutom())
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                            child:Container(
                              color: Colors.white,
                              width: _w-20,
                              height: 1,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.cloudy_snowing , color: Colors.white,),
                              ),
                              Text("Season".tr + " : ", style: TextStyle(fontSize: 15, color: Colors.white)),
                              Expanded(child: EditeSeason_Type())
                            ],
                          ),  Padding(
                            padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                            child:Container(
                              color: Colors.white,
                              width: _w-20,
                              height: 1,
                            ),
                          ),
                          GestureDetector(
                          onTap: (){
                          EditeName(context , provider.tripName.toString());
                          },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.nature_people , color: Colors.white,),
                                ),
                                Text("Name".tr+" : ${provider.tripName}", style: TextStyle(fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),  Padding(
                            padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                            child:Container(
                              color: Colors.white,
                              width: _w-20,
                              height: 1,
                            ),
                          ),
                        GestureDetector(
                          onTap: (){
                            EditeDate(context);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.settings_system_daydream , color: Colors.white,),
                                  ),
                                  Text("Day Count".tr+" : ${provider.daysCount} "+"Days".tr, style: TextStyle(fontSize: 15, color: Colors.white)),
                                ],
                              ),  Padding(
                                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                                child:Container(
                                  color: Colors.white,
                                  width: _w-20,
                                  height: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.date_range , color: Colors.white,),
                                  ),
                                  Text("Start Trip".tr+" :${provider.startDate}", style: TextStyle(fontSize: 15, color: Colors.white)),
                                ],
                              ),  Padding(
                                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                                child:Container(
                                  color: Colors.white,
                                  width: _w-20,
                                  height: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.date_range_outlined , color: Colors.white,),
                                  ),
                                  Text("End Booking".tr+" :${provider.endDate}", style: TextStyle(fontSize: 15, color: Colors.white)),
                                ],
                              ),  Padding(
                                padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                                child:Container(
                                  color: Colors.white,
                                  width: _w-20,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                          GestureDetector(
                            onTap: (){
                              EditeSallary(context,provider.pricePerPerson.toString());
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.monetization_on , color: Colors.white,),
                                ),
                                Text("Salary".tr+" : ${provider.pricePerPerson} "+"For One People".tr, style: TextStyle(fontSize: 15, color: Colors.white)),
                              ],
                            ),
                          ),  Padding(
                            padding: const EdgeInsets.only(bottom: 18.0 , top: 15.0),
                            child:Container(
                              color: Colors.white,
                              width: _w-20,
                              height: 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedatebooking(context);
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.people_alt_rounded , color: Colors.white,),
                                ),
                                Text("End Date Booking".tr+" : ${provider.bookingEndDate}" , style: TextStyle(fontSize: 15, color: Colors.white,),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0 , left: 8.0 ,bottom: 8.0,right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Activitys".tr , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
                        ,IconButton(onPressed: (){
                            _scrollController.animateTo(_scrollController.offset*10, duration: Duration(seconds: 1), curve: Curves.easeIn,);
                            Provider.of<Activitys_Edite_Provider>(context,listen: false).clearEmpty();
                            Provider.of<Activitys_Edite_Provider>(context,listen: false).addNewActivity();
                        }, icon: Icon(Icons.add))
                      ],
                    ),
                  ),
                  Consumer<Activitys_Edite_Provider>(
                    builder: (context, provider, child) {
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
                            itemCount: provider.Activitys.length ,
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
                          _scrollController.animateTo(_scrollController.offset*10, duration: Duration(seconds: 1), curve: Curves.easeIn,);
                          Provider.of<Services_Edite_Provider>(context,listen: false).clearEmpty();
                          Provider.of<Services_Edite_Provider>(context,listen: false).addNewServicess();
                        }, icon: Icon(Icons.add))
                      ],
                    ),
                  ),
                  Consumer<Services_Edite_Provider>(
                    builder: (context, provider, child) {

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
            ],
          )
      );
  },
),
    );
  }
}
