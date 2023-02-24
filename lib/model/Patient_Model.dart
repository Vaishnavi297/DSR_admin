class PatientModel {
  String? id;
  String? fullName;
  String? email;
  String? gender;
  var age;
  var mobileNumber;
  String? createdAt;
  String? updatedAt;
  String? password;
  String? height;
  String? weight;

  PatientModel({
    this.id,
    this.fullName,
    this.email,
    this.gender,
    this.age,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.height,
    this.weight,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    mobileNumber = json['mobileNumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    password = json['password'];
    height = json['height'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['age'] = this.age;
    data['mobileNumber'] = this.mobileNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['password'] = this.password;
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}
