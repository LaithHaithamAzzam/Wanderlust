import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Wallet/SelectedPay.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  @override
  int counter = 1;
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
                  Text("Set Person Numper",style: TextStyle(color: Colors.white),),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0 , right: 25.0 , top: 30.0),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                         if(counter >1){
                           counter-- ;
                         }
                          });
                        }, icon: Icon(Icons.exposure_minus_1,color: Colors.white,)),
                        Expanded(
                          child: Center(child: Text("$counter" , style: TextStyle(color: Colors.white , fontSize: 23),))
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            counter++ ;
                          });
                        }, icon: Icon(Icons.plus_one,color: Colors.white,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 20.0 , right: 20.0),
                    child: Hero(
                      tag: "BookBTN",
                      child: TextButton(
                        onPressed: ()async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectPay(counter: counter, editebooking: false,),));
                           },
                        child: Text("Booking Now".tr),
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                            backgroundColor:MaterialStatePropertyAll(Color(
                                0xff1fbda2)),
                            minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width-10 , 60)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))))
                        ),
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
