class DashboardModel {
  Dashboard? dashboard;

  DashboardModel({this.dashboard});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'] != null
        ? new Dashboard.fromJson(json['dashboard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.toJson();
    }
    return data;
  }
}

class Dashboard {
  int? target;
  int? caloriesLeft;
  int? caloriesTaken;
  int? totalCarbsInG;
  int? totalFatsInG;
  int? totalProteinInG;

  Dashboard(
      {this.target,
      this.caloriesLeft,
      this.caloriesTaken,
      this.totalCarbsInG,
      this.totalFatsInG,
      this.totalProteinInG});

  Dashboard.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    caloriesLeft = json['calories_left'];
    caloriesTaken = json['calories_taken'];
    totalCarbsInG = json['total_carbs_in_g'];
    totalFatsInG = json['total_fats_in_g'];
    totalProteinInG = json['total_protein_in_g'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target'] = this.target;
    data['calories_left'] = this.caloriesLeft;
    data['calories_taken'] = this.caloriesTaken;
    data['total_carbs_in_g'] = this.totalCarbsInG;
    data['total_fats_in_g'] = this.totalFatsInG;
    data['total_protein_in_g'] = this.totalProteinInG;
    return data;
  }
}
