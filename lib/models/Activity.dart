class Activity {
  String activityId;
  String date;
  String wakeUp;
  String wakeUpImage;
  String totalSteps;
  String totalStepsImage;

  Activity(
      {this.activityId,
      this.date,
      this.wakeUp,
      this.wakeUpImage,
      this.totalSteps,
      this.totalStepsImage});

  Activity.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    date = json['date'];
    wakeUp = json['wakeUp'];
    wakeUpImage = json['wakeUpImage'];
    totalSteps = json['totalSteps'];
    totalStepsImage = json['totalStepsImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['date'] = this.date;
    data['wakeUp'] = this.wakeUp;
    data['wakeUpImage'] = this.wakeUpImage;
    data['totalSteps'] = this.totalSteps;
    data['totalStepsImage'] = this.totalStepsImage;
    return data;
  }
}