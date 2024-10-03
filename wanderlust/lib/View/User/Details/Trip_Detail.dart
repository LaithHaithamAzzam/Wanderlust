import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/AddFav_API.dart';
import 'package:wanderlust/Controller/Api.dart';
import 'package:wanderlust/Controller/DeleteBooking_API.dart';
import 'package:wanderlust/Controller/RemovFav_API.dart';
import 'package:wanderlust/View/MyWidgets/BottomSheet.dart';
import 'package:wanderlust/View/MyWidgets/EditeBooking.dart';
import 'package:wanderlust/View/MyWidgets/buttons.dart';
import 'package:wanderlust/Wallet/SelectedPay.dart';
import 'package:wanderlust/locale/local_controller.dart';

import '../../../Provider/trip_Provider.dart';

class Trip_Details extends StatefulWidget {
   Trip_Details({required this.heroindex , super.key});
  int heroindex;

  @override
  State<Trip_Details> createState() => _Trip_DetailsState();
}

class _Trip_DetailsState extends State<Trip_Details> {
  ScrollController sc = ScrollController();

   @override
   Widget build(BuildContext context) {

    localeController lc = Get.find();
    var mnalg =  MainAxisAlignment.start;
    var txdir = lc.language.contains("en")? TextDirection.ltr : TextDirection.rtl;


    double _w = MediaQuery.of(context).size.width;
    return Consumer<Trips_Provider>(
  builder: (context, provider, child) {
    bool isfav = provider.Isfav!;

    List<String> datecomp = provider.bookingEndDate!.split("-");
    DateTime stdate = DateTime(int.parse(datecomp[0]),int.parse(datecomp[1]),int.parse(datecomp[2]));
    int Day =  int.parse((DateTime.now().difference(stdate).inDays).toString());

    bool Isended = Day.isNegative;
  return Scaffold(
      bottomNavigationBar: Isended?Padding(
        padding: const EdgeInsets.all(8.0),
        child: provider.isbooking == true ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButtonCustom(color: Colors.redAccent,Textcolor: Colors.white
              ,onpressed:()async{
               await DeletebookingApi(context).Deletebooking(provider.tripId!);

              } ,materialtext:"Remove Booking".tr ,height: 60,width: _w/2.2,),

            MaterialButtonCustom(color: Theme.of(context).primaryColor,Textcolor: Colors.white
              ,onpressed:(){
                showModalBottomSheet(
                  context: context,
                  builder: (context) => editeBottomsheet(counter: provider.personCount!,),
                );
              } ,materialtext:"Edite Booking".tr ,height: 60,width: _w/2.2,),

          ],
        ):
        MaterialButtonCustom(color: Theme.of(context).primaryColor,Textcolor: Colors.white
          ,onpressed:(){
            showModalBottomSheet(
              context: context,
              builder: (context) => Bottomsheet(),
            );

          }
          ,materialtext:"Booking Now".tr ,height: 60,width: _w,),
      ):
          Container(
            alignment: Alignment.center,
              height: 60,
              width: _w,
            color:  Theme.of(context).primaryColor,
            child: Text("Reservations have ended".tr,style: TextStyle(color: Colors.white , fontSize: 18),),
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: "image${widget.heroindex}",
                  child: Container(
                    alignment: Alignment.center,
                    width: _w,
                    height: _w-80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                        image: DecorationImage(image: NetworkImage("$imagesurl/"+"${provider.photo}"),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child:IconButton(style:ButtonStyle(
                    iconSize: MaterialStatePropertyAll(20),
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor,)
                ),onPressed: ()async {
                      if(isfav==false){
                      await AddFavAPI(context).addFav(int.parse((provider.tripId).toString()));
                      }
                      else{
                        await RemoveFavAPI(context).RemoveFav(int.parse((provider.tripId).toString()));
                      }
                  }, icon: Icon( isfav == true ?Icons.star:Icons.star_border , color:  Colors.white ,)),),

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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0 ,left: 8.0),
                              child: Icon(Icons.swap_horizontal_circle , color: Colors.white,),
                            ),
                            Text("Type".tr+" : "+"${provider.type}".tr, style: TextStyle(fontSize: 15 , color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.nature_people , color: Colors.white,),
                            ),
                            Text("Name".tr+" : ${provider.tripName}", style: TextStyle(fontSize: 15, color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.date_range , color: Colors.white,),
                            ),
                            Text("Start Trip".tr+" : ${provider.startDate}", style: TextStyle(fontSize: 15, color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.date_range_outlined , color: Colors.white,),
                            ),
                            Text("End Booking".tr+" : ${provider.endDate}", style: TextStyle(fontSize: 15, color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.cloudy_snowing , color: Colors.white,),
                            ),
                            Text("Season".tr+" : "+"${provider.season}".tr, style: TextStyle(fontSize: 15, color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.monetization_on , color: Colors.white,),
                            ),
                            Text("Salary".tr+" : ${provider.pricePerPerson} "+"For One People".tr, style: TextStyle(fontSize: 15, color: Colors.white)),
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
                          mainAxisAlignment: mnalg,
                          textDirection: txdir,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                              child: Icon(Icons.people_alt_rounded , color: Colors.white,),
                            ),
                            Text("End Date Booking".tr+" : ${provider.bookingEndDate}" , style: TextStyle(fontSize: 15, color: Colors.white,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0 , left: 8.0 ,right: 8.0,bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: mnalg,
                    textDirection: txdir,
                    children: [
                      Text("Activitys".tr , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: _w,
                  height: (provider.activities!.length*65)+50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.all(Radius.circular(9))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                    child: ListView.builder(
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: provider.activities!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: mnalg,
                              textDirection: txdir,
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
                                  padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: mnalg,
                                    textDirection: txdir,
                                    children: [
                                      Text("${provider.activities![index].activity}"),
                                    ],
                                  )
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
                ),
              ],
            ),
            Column(
              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 8.0 , left: 8.0 ,right: 8.0,bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: mnalg,
                    textDirection: txdir,
                    children: [
                      Text("Services".tr , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ,))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: _w,
                  height: (provider.services!.length*65)+50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.all(Radius.circular(9))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                    child: ListView.builder(
                      physics:NeverScrollableScrollPhysics(),
                      itemCount: provider.services!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: mnalg,
                              textDirection: txdir,
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
                                    padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
                                    child: Row(
                                      mainAxisAlignment: mnalg,
                                      textDirection: txdir,
                                      children: [
                                        Text("${provider.services![index].service}"),
                                      ],
                                    )
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
                ),
              ],
            ),
             ],
           )
      )

    );
  },
);
  }
}
