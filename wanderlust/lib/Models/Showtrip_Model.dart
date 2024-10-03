class trip_Model {
  bool? isbooking;
  int? personCount;
  String? type;
  Trip? trip;

  trip_Model({this.isbooking, this.personCount, this.type, this.trip});

  trip_Model.fromJson(Map<String, dynamic> json) {
    isbooking = json['isbooking'];
    personCount = json['person_count'];
    type = json['type'];
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isbooking'] = this.isbooking;
    data['person_count'] = this.personCount;
    data['type'] = this.type;
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    return data;
  }
}

class Trip {
  int? tripId;
  String? createdAt;
  String? updatedAt;
  String? photo;
  String? season;
  String? tripName;
  int? pricePerPerson;
  String? startDate;
  String? endDate;
  int? daysCount;
  String? bookingEndDate;
  int? typeId;
  List<Services>? services;
  List<Activities>? activities;

  Trip(
      {this.tripId,
        this.createdAt,
        this.updatedAt,
        this.photo,
        this.season,
        this.tripName,
        this.pricePerPerson,
        this.startDate,
        this.endDate,
        this.daysCount,
        this.bookingEndDate,
        this.typeId,
        this.services,
        this.activities});

  Trip.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
    season = json['season'];
    tripName = json['trip_name'];
    pricePerPerson = json['price_per_person'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    daysCount = json['days_count'];
    bookingEndDate = json['booking_end_date'];
    typeId = json['type_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = this.photo;
    data['season'] = this.season;
    data['trip_name'] = this.tripName;
    data['price_per_person'] = this.pricePerPerson;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['days_count'] = this.daysCount;
    data['booking_end_date'] = this.bookingEndDate;
    data['type_id'] = this.typeId;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? service;
  int? tripId;

  Services(
      {this.id, this.createdAt, this.updatedAt, this.service, this.tripId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'];
    tripId = json['trip_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['service'] = this.service;
    data['trip_id'] = this.tripId;
    return data;
  }
}

class Activities {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? activity;
  int? tripId;

  Activities(
      {this.id, this.createdAt, this.updatedAt, this.activity, this.tripId});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activity = json['activity'];
    tripId = json['trip_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['activity'] = this.activity;
    data['trip_id'] = this.tripId;
    return data;
  }
}
