class ShowAllTrips_Model {
  List<Data>? data;

  ShowAllTrips_Model({this.data});

  ShowAllTrips_Model.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? tripId;
  String? name;
  String? type;
  int? daysCount;
  String? bookingEndDate;
  String? photopath;

  Data(
      {this.tripId,
        this.name,
        this.type,
        this.daysCount,
        this.bookingEndDate,
        this.photopath});

  Data.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    name = json['name'];
    type = json['type'];
    daysCount = json['days_count'];
    bookingEndDate = json['booking_end_date'];
    photopath = json['photopath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['days_count'] = this.daysCount;
    data['booking_end_date'] = this.bookingEndDate;
    data['photopath'] = this.photopath;
    return data;
  }
}
