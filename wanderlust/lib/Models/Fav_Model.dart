class Fav_Model {
  List<Favourites>? favourites;

  Fav_Model({this.favourites});

  Fav_Model.fromJson(Map<String, dynamic> json) {
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(new Favourites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favourites != null) {
      data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favourites {
  int? tripId;
  String? name;
  String? type;
  int? daysCount;
  String? bookingEndDate;
  String? photopath;

  Favourites(
      {this.tripId,
        this.name,
        this.type,
        this.daysCount,
        this.bookingEndDate,
        this.photopath});

  Favourites.fromJson(Map<String, dynamic> json) {
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
