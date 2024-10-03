import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Api.dart';
import 'package:wanderlust/Controller/showtripbyid.dart';

import '../../../Provider/FavProvider.dart';

class FavScreen extends StatelessWidget {
  FavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("My Favorite".tr),
        ),
        body: Consumer<Fav_provider>(
  builder: (context, provider, child) {
  return provider.favourites != null ? ListView.builder(itemCount: provider.favourites!.length,itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 15.0 , bottom: 15.0),
            child: GestureDetector(
              onTap: ()async{
                await ShowTrip(context).ShowsTrip(int.parse((provider.favourites![index].tripId).toString()),false,index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width ,
                    height: 175,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6)),
                        image: DecorationImage(image: NetworkImage("$imagesurl/${provider.favourites![index].photopath}"),fit: BoxFit.cover)
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
                                                Text("${provider.favourites![index].name}" , style: TextStyle(color: Colors.white),),
                                                Text("${provider.favourites![index].type}".tr , style: TextStyle(color: Colors.white),),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 18.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("${provider.favourites![index].daysCount} "+"Days".tr , style: TextStyle(color: Colors.white),),
                                                  Text("End In".tr+" : ${provider.favourites![index].bookingEndDate!.replaceAll("T21:00:00.000000Z", "")}" , style: TextStyle(color: Colors.white),),

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
          );
        },):  Center(
    child: Text("No Trips Added To Favorite".tr , style: TextStyle(color: Theme.of(context).primaryColor),),
  );
  },
)
    );
  }
}
