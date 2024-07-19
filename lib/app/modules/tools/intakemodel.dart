class CMDateModel {
  int? id;
  String? date;
  int? timestamp;

  CMDateModel({this.id, this.date});

  CMDateModel.fromJson(Map<String, dynamic> json) {
    id = json['date_id'];
    date = json['date'];
    timestamp = json['timestamp'];
  }
}

class CMIntakemodel {
  int? id;
  int? dateID;
  bool? isIntake;
  int? timestamp;
  String? name;
  int? kcal;
  String? dateStr;
  String? iconName;

  CMIntakemodel(
      {this.id,
      this.dateID,
      this.isIntake,
      this.timestamp,
      this.name,
      this.kcal,
      this.iconName,
      this.dateStr});

  CMIntakemodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateID = json['date_id'];
    isIntake = json['isIntake'] == 1;
    timestamp = json['timestamp'];
    name = json["name"];
    kcal = json['kcal'];
    iconName = json['iconName'];
    dateStr = json['dateStr'];
  }
}
