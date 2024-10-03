class Notifications_Model {
  List<Notifications>? notifications;

  Notifications_Model({this.notifications});

  Notifications_Model.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? tripId;
  String? startDate;
  int? personCount;
  String? tripName;
  int? userId;

  Notifications(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.tripId,
        this.startDate,
        this.personCount,
        this.tripName,
        this.userId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tripId = json['trip_id'];
    startDate = json['start_date'];
    personCount = json['person_count'];
    tripName = json['trip_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['trip_id'] = this.tripId;
    data['start_date'] = this.startDate;
    data['person_count'] = this.personCount;
    data['trip_name'] = this.tripName;
    data['user_id'] = this.userId;
    return data;
  }
}
