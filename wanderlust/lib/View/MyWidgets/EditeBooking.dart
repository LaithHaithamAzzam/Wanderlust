import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Wallet/SelectedPay.dart';

import '../../Provider/trip_Provider.dart';

class editeBottomsheet extends StatefulWidget {
   editeBottomsheet({ required this.counter , super.key});
  int counter;
  @override
  State<editeBottomsheet> createState() => _editeBottomsheetState();
}

class _editeBottomsheetState extends State<editeBottomsheet> {
  @override

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0 , bottom: 10.0),
            child: Text("Booking Trip".tr , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 16),),
          ) ,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Insert Person Numper",style: TextStyle(color: Colors.white),),

            Padding(
            padding: const EdgeInsets.only(left: 25.0 , right: 25.0 , top: 30.0),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  setState(() {
                    if(widget.counter >1){
                      widget.counter-- ;
                    }
                  });
                }, icon: Icon(Icons.exposure_minus_1,color: Colors.white,)),
                Expanded(
                    child: Center(child: Text("${widget.counter}" , style: TextStyle(color: Colors.white , fontSize: 23),))
                ),
                IconButton(onPressed: (){
                  setState(() {
                    widget.counter++ ;
                  });
                }, icon: Icon(Icons.plus_one,color: Colors.white,)),
              ],
            ),
          ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 20.0 , right: 20.0),
                    child: Hero(
                      tag: "BookBTN",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: ()async {
                             if(widget.counter != Provider.of<Trips_Provider>(context , listen: false).personCount ){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectPay(counter: widget.counter, editebooking: true,),));
                             }
                             else{

                             }
                             },
                            child: Text("Done Editing".tr),
                            style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(Colors.white),
                                backgroundColor:
                                widget.counter != Provider.of<Trips_Provider>(context , listen: false).personCount ?
                                MaterialStatePropertyAll(Color(
                                    0xff1fbda2)):MaterialStatePropertyAll(Colors.grey),
                                minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width - 40, 60)),
                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))))
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
