import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Controller/Booking_API.dart';
import 'package:wanderlust/Controller/EditeBooking.dart';
import 'package:wanderlust/Wallet/DoneBooking.dart';
import 'package:wanderlust/Wallet/PypalWallet.dart';

import '../Provider/trip_Provider.dart';

class SelectPay extends StatefulWidget {
   SelectPay({super.key , required this.counter ,  required this.editebooking});
 int counter;
 bool editebooking;
  @override
  State<SelectPay> createState() => _SelectPayState();
}
int selectiongrp =  0 ;
int mount = 0;
class _SelectPayState extends State<SelectPay> {
  @override
  Widget build(BuildContext context) {
    if(widget.editebooking == true){
       mount = (((widget.counter - int.parse(Provider.of<Trips_Provider>(context,listen: false).personCount.toString()) )*int.parse((Provider.of<Trips_Provider>(context,listen: false).pricePerPerson).toString())));

    }
    else{
      mount = (widget.counter * int.parse((Provider.of<Trips_Provider>(context,listen: false).pricePerPerson).toString()));
    }
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0,left: 5.0 , right: 5.0),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment:  mount.isNegative ?  MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
                children: [
                  mount.isNegative ? Text(""):Text("Order Total".tr , style: TextStyle(fontWeight: FontWeight.bold),),
                  mount.isNegative ? Text("It will be returned".tr+" ${mount.abs()} "+"SP".tr+" "+"to your wallet".tr , style: TextStyle(fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,) : Text("$mount"+" SP" , style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            TextButton(
              onPressed: ()async{
                   if(selectiongrp == 1){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => PypalWallet(),));

                   }else{

                 if(widget.editebooking == true){
                   await EditeBooking(context).EditeBooking_API(
                       Provider.of<Trips_Provider>(context , listen:false).tripId.toString()
                       , widget.counter);
                 }else{
                   await Booking(context).Booking_API(
                       Provider.of<Trips_Provider>(context , listen:false).tripId.toString()
                       , widget.counter);
                 }
                   }
                 },
              child: Text("Booking Now".tr),
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor:MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width-10 , 60)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))))
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Booking Trip".tr),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
          margin: EdgeInsets.all(25.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RadioListTile(
                  secondary: Icon(Icons.wallet,color: Theme.of(context).primaryColor,size: 25),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                  title: Center(child: Text("Wanderlust Wallet")),
                  value: 0,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: selectiongrp,
                  onChanged: (int? value) {
                   setState(() {
                     selectiongrp = value!;
                   });
                  },
                              ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: GestureDetector(
                    onTap: (){
                    },
                    child: RadioListTile(
                    secondary: Icon(Icons.paypal,color: Theme.of(context).primaryColor,size: 25),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                    title: Center(child: Text("PayPal")),
                    value: 1,
                    activeColor: Theme.of(context).primaryColor,
                    groupValue: selectiongrp,
                    onChanged: (int? value) {
                      setState(() {
                        selectiongrp = value!;
                      });
                    },
                                ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RadioListTile(
                  secondary: Icon(Icons.apple,color: Theme.of(context).primaryColor,size: 25),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                  title: Center(child: Text("Apple Pay")),
                  value: 2,
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: selectiongrp,
                  onChanged: (int? value) {
                  },
                              ),
                ),
                RadioListTile(
                secondary: Icon(Icons.payments_outlined,color: Theme.of(context).primaryColor,size: 25),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)),side: BorderSide(color: Theme.of(context).primaryColor)),
                title: Center(child: Text("Syriatel Cash")),
                value: 3,
                activeColor: Theme.of(context).primaryColor,
                groupValue: selectiongrp,
                onChanged: (int? value) {
                },
                            ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
