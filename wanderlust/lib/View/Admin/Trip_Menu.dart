import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Api.dart';
import 'package:wanderlust/Controller/Delete_Trip.dart';
import 'package:wanderlust/Controller/showtripbyid.dart';
import 'package:wanderlust/Provider/Activitys_Provider.dart';
import 'package:wanderlust/Provider/AllTrips_Provider.dart';
import 'package:wanderlust/Provider/Services_Provider.dart';
import 'package:wanderlust/View/Admin/Add_Trip.dart';
import 'package:wanderlust/View/Admin/Trip_det_Admin.dart';
import 'package:wanderlust/View/User/Details/Trip_Detail.dart';

import '../../Controller/ShowAllTrips_API.dart';
import '../../Provider/Imageprovider.dart';


class Trip_Menu extends StatelessWidget {
   Trip_Menu({required this.IsAdmin,super.key});
   bool IsAdmin;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(
        title:Text( "Trip Menu".tr),
        actions: [
          IsAdmin == true ? IconButton(onPressed: (){
            Provider.of<Activitys_Provider>(context,listen: false).Activitys.clear();
            Provider.of<Services_Provider>(context,listen: false).Services.clear();
            Provider.of<Imageprovider>(context , listen: false).image=null;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add_Trip(),));
          }, icon: Icon(Icons.add) , color: Colors.white,):
              Text("")
        ],
      ),
      body: Consumer<AllTrips_Provider>(
  builder: (context, allTrips_Provider, child) {
  return allTrips_Provider.data != null ? ListView.builder(itemCount: allTrips_Provider.data!.length,itemBuilder: (context, index) {
        return  Stack(
          children: [
            GestureDetector(
              onTap: ()async{
              await ShowTrip(context).ShowsTrip(int.parse((allTrips_Provider.data![index].tripId).toString()),IsAdmin,index);

              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 15.0 , bottom: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                      tag: "image$index",
                      child: Container(
                        width: width ,
                        height: 175,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                            image: DecorationImage(image: NetworkImage("$imagesurl/"+"${allTrips_Provider.data![index].photopath}"),fit: BoxFit.cover)
                        ),
                      ),
                    ),   Container(
                      width: width ,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${allTrips_Provider.data![index].name}" , style: TextStyle(color: Colors.white),),
                                Text("${allTrips_Provider.data![index].type}".tr , style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${allTrips_Provider.data![index].daysCount} "+ "Days".tr , style: TextStyle(color: Colors.white),),
                                  Text("${allTrips_Provider.data![index].bookingEndDate?.replaceAll("T21:00:00.000000Z", "")}" , style: TextStyle(color: Colors.white),),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IsAdmin==true?  Positioned(
                top: 25,
                left: 15,
                child: IconButton(
                  style: ButtonStyle(
                    iconSize: MaterialStatePropertyAll(16),
                    minimumSize: MaterialStatePropertyAll(Size(35, 35)),
                    maximumSize: MaterialStatePropertyAll(Size(35, 35)),
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                  ),
                    onPressed: ()async{
                    await  DeleteTripAPI(context).DeleteTripREQ(int.parse((allTrips_Provider.data![index].tripId).toString()));
                    },
                    icon: Icon(Icons.delete ,
                      color: Colors.white,))):Text("")
          ],
        );
      },):
  Center(
    child: Text("No Trips Added".tr , style: TextStyle(color: Theme.of(context).primaryColor),),
  );
  },
)
    );
  }
}
