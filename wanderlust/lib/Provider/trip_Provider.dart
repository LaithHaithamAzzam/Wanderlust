import 'package:flutter/cupertino.dart';
import 'package:wanderlust/Models/Showtrip_Model.dart';


class Trips_Provider extends ChangeNotifier{
  int? tripId;
  String? photo;
  String? type;
  String? season;
  String? tripName;
  int? pricePerPerson;
  String? startDate;
  String? endDate;
  int? daysCount;
  String? bookingEndDate;
  List<Services>? services;
  List<Activities>? activities;
  bool? isbooking;
  bool? Isfav;
  int? personCount;

  settrip(
  int? TripId,
  String? Photo,
  String? Type,
  String? Season,
  String? TripName,
  int? PricePerPerson,
  String? StartDate,
  String? EndDate,
  int? DaysCount,
  String? BookingEndDate,
  List<Services>? Services,
  List<Activities>? Activities,
      bool? Isbooking,
      int? PersonCount,
      bool isfav
  ){
    tripId = TripId;
    photo = Photo;
    type = Type;
    season = Season;
    tripName = TripName;
    pricePerPerson = PricePerPerson;
    startDate = StartDate?.replaceAll("T21:00:00.000000Z", "");
    endDate = EndDate?.replaceAll("T21:00:00.000000Z", "");
    daysCount = DaysCount;
    bookingEndDate = BookingEndDate?.replaceAll("T21:00:00.000000Z", "");
    services = Services;
    activities = Activities;
    isbooking = Isbooking;
    personCount = PersonCount;
    Isfav = isfav;
    notifyListeners();
  }
setIsbook(isbook){
  isbooking = isbook;
  notifyListeners();
}
setIsfav(isfavorite){
  Isfav = isfavorite;
  notifyListeners();
}
  setpersonCount(pcount){
    personCount = pcount;
    notifyListeners();
  }
  setName(TripName){
    tripName = TripName ;
    notifyListeners();
  }

  setsallry(int sallry){
    pricePerPerson = sallry ;
    notifyListeners();
  }

  setphotopath(String photoPath){
    photo = photoPath ;
    notifyListeners();
  }

  setEndDateBooking(String Enddatebooking){
    bookingEndDate = Enddatebooking ;
    notifyListeners();
  }

  setType(TypeName){
    type = TypeName ;
    notifyListeners();
  }

  setSeason(Season){
    season = Season ;
    notifyListeners();
  }

  setDate(DateTime StartDate,DateTime EndDate ){
    startDate = StartDate.toString().replaceAll("00:00:00.000", "") ;
    endDate = EndDate.toString().replaceAll("00:00:00.000", "");
    daysCount =  int.parse((EndDate.difference(StartDate).inDays + 1).toString());
    notifyListeners();
  }

}