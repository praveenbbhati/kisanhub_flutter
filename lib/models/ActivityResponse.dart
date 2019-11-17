import './Activity.dart';

class ActivityResponse {
  int total;
  List<Activity> activities;

  ActivityResponse({this.total, this.activities});

  ActivityResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['activities'] != null) {
      activities = new List<Activity>();
      json['activities'].forEach((v) {
        activities.add(new Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
