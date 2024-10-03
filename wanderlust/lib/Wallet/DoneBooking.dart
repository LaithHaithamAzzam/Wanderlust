import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class DoneBooking extends StatefulWidget {
   DoneBooking({super.key , required this.Booking});
  bool Booking;
  @override
  State<DoneBooking> createState() => _DoneBookingState();
}

class _DoneBookingState extends State<DoneBooking> {
@override

  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () {
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),),(route) => false,);
          return Future(() => false);
        },
        child: Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0 , bottom: 50.0),
                child: TextButton(
                  onPressed: () {
                    if(widget.Booking)
                      {
                        context.pop();
                        context.pop();
                        context.pop();
                        context.pop();
                      }
                    else{
                      context.pop();
                    }

                  },
                  child: Text("OK"),
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                      minimumSize: MaterialStatePropertyAll(Size(MediaQuery
                          .of(context)
                          .size
                          .width - 40, 60)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))))
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                      child: Icon(widget.Booking ? Icons.check_circle : Icons.error, color: widget.Booking ? Theme.of(context).primaryColor : Colors.red,
                        size: MediaQuery
                            .of(context)
                            .size
                            .width / 2,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Order Detiles", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 3,

                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Text(
                        "",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                      child: widget.Booking ? Text(textAlign: TextAlign.center,
                        "thank you for your order." +"\n" +"check your Notification to show Your Trip",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),):
                      Text(textAlign: TextAlign.center,
                        "You Dont Have Enough Money In Your Wallet" +"\n" +"check your Wallet and try again",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
