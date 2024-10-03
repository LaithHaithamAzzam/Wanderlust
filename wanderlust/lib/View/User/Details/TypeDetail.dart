import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Api.dart';
import 'package:wanderlust/Controller/showtripbyid.dart';
import 'package:wanderlust/Provider/AllTrips_Provider.dart';


class TypeDetail extends StatelessWidget {
   TypeDetail({required this.Title ,super.key});
  String Title;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("$Title"),
      ),
      body: Consumer<AllTrips_Provider>(
  builder: (context, provider, child) {

  return provider.data != null ? ListView.builder(itemCount: provider.data!.length,itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 15.0 , bottom: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: ()async{
                  await ShowTrip(context).ShowsTrip(int.parse((provider.data![index].tripId).toString()),false,index);
                },
                child: Hero(
                  tag: "image$index",
                  child: Container(
                    width: width ,
                    height: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                      image: DecorationImage(image: NetworkImage("$imagesurl/${provider.data![index].photopath}"),fit: BoxFit.cover)
                    ),
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
                          Text("${provider.data![index].name}" , style: TextStyle(color: Colors.white),),
                          Text("$Title" , style: TextStyle(color: Colors.white),),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${provider.data![index].daysCount} "+"Days".tr , style: TextStyle(color: Colors.white),),
                            Text("End In".tr+" : ${provider.data![index].bookingEndDate?.replaceAll("T21:00:00.000000Z", "")}" , style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },): Center(
    child: Text("No Trips Added".tr , style: TextStyle(color: Theme.of(context).primaryColor),),
  );
  },
)
    );
  }
}
