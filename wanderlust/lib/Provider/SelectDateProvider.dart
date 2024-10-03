import 'package:flutter/cupertino.dart';

class SelectDate extends ChangeNotifier{
  DateTime? stardate;
  DateTime? enddate;
  DateTime? enddatebooking;
  String? DayCount;
  bool isopen = false;
  SetDate(DateTime std ,DateTime endd){
    DayCount =  (endd.difference(std).inDays + 1).toString();
    stardate = std;
    enddate = endd;
    notifyListeners();
  }
  setendDateBooking(DateTime date){
    enddatebooking = date;
    isopen = true;
    notifyListeners();

  }
}




