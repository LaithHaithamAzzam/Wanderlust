import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Delete_All_Notifications.dart';
import 'package:wanderlust/Controller/GatAllNotifications.dart';
import 'package:wanderlust/Controller/showtripbyid.dart';
import 'package:wanderlust/View/Admin/Trip_Menu.dart';
import 'package:wanderlust/locale/local_controller.dart';

import '../../../Provider/Notifications_Provider.dart';

class Notifications_Screen extends StatelessWidget {
  const Notifications_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    localeController lc = Get.find();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            await DeleteAllNotifications(context).deletenotifi();
          },
              icon: Icon(Icons.delete )),
          IconButton(onPressed: ()async{
            await Notifications_API(context).ShowNotifications(false);
          }, icon: Icon(Icons.refresh)),
        ],
        title: Text("Notifications".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0 ,bottom: 5.0),
        child: Consumer<Notifications_Provider>(
        builder: (context, provider, child) {
          return provider.notifications != null ? ListView.builder(itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0 , right: 5.0),
            child: Column(
              children: [
                ListTile(
                  hoverColor: Theme.of(context).primaryColor,
                  splashColor: Theme.of(context).primaryColor.withAlpha(50),
                  trailing: Icon(Icons.navigate_next),
                  onTap: ()async{
                    await ShowTrip(context).ShowsTrip(int.parse((provider.notifications![index].tripId).toString()), false, index);
                  },
                  tileColor: index%2 == 0 ? Colors.white : Colors.grey.shade300,
                  title: Text("${provider.notifications![index].tripName}" , style: TextStyle(color: Theme.of(context).primaryColor , fontWeight: FontWeight.bold),),
                  leading: Icon(Icons.car_repair_outlined , color: Theme.of(context).primaryColor,size: 28,),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                         children: [
                          Icon(Icons.date_range_outlined , size: 15,),
                              Text("Start Trip".tr+" : "+"${provider.notifications![index].startDate!.replaceAll("00:00:00", "")}"),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person , size: 15,),
                          Text("Person Count".tr+" : ( ${provider.notifications![index].personCount} )"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-10,
                  height: 2,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
        itemCount: provider.notifications!.length,
        ):
          Center(
            child: Text("No Notifications".tr , style: TextStyle(color: Theme.of(context).primaryColor),),
          );
  },
),
      ),
    );
  }
}
