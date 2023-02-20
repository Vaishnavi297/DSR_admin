class StepCaloriesModel {
  String? burnCalories;
  String? date;
  double? stepCount;

  StepCaloriesModel(this.burnCalories, this.date, this.stepCount);

  StepCaloriesModel.fromJson(Map<String, dynamic> json) {
    burnCalories = json['burn_calories'];
    date = json['date'];
    stepCount = json['step_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['burn_calories'] = this.burnCalories;
    data['date'] = this.date;
    data['step_count'] = this.stepCount;

    return data;
  }
}
