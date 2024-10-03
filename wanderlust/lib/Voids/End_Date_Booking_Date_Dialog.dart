import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wanderlust/Provider/SelectDateProvider.dart';

Future<void> selectedatebooking(BuildContext context) async {
 bool isedite = false;
  return showDialog<void>(
    context: context,

    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: const Color(0xffffffff),
        backgroundColor: Theme.of(context).primaryColor,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        title:  Text(
          'Select End Date Booking'.tr,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          primaryColor: Color(0xffffffff),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        maximumDate: DateTime(DateTime.now().year+2),
                        minimumDate:  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                        maximumYear: DateTime.now().year,
                        onDateTimeChanged: (DateTime newDateTime) {
                          isedite = true;
                          Provider.of<SelectDate>(context, listen: false)
                              .setendDateBooking(newDateTime);
                        },
                      ),
                    )),
                TextButton(
                  onPressed: () {

                       if(isedite == true){
                      Navigator.of(context).pop();
                    }
                    else{
                      Navigator.of(context).pop();
                            DateTime start = DateTime(DateTime.now().year , DateTime.now().month,DateTime.now().day);
                      Provider.of<SelectDate>(context , listen: false).setendDateBooking(
                             start
                      );
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Color(0xffffffff))),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Color(0xff3b4e52)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}