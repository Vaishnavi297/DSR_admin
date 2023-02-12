class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? gender;
  String? age;
  String? mobileNumber;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.gender,
    this.age,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    mobileNumber = json['mobileNumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['age'] = this.age;
    data['mobileNumber'] = this.mobileNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
