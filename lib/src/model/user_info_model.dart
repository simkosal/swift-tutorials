class AuthModel {
  Data? data;
  dynamic rawJson;

  AuthModel({this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  User? userInfo;
  Principle? principle;

  Data({this.accessToken, this.userInfo, this.principle});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userInfo =
        json['userInfo'] != null ? new User.fromJson(json['userInfo']) : null;
    principle = json['principle'] != null
        ? new Principle.fromJson(json['principle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    if (this.principle != null) {
      data['principle'] = this.principle!.toJson();
    }
    return data;
  }
}

class User {
  String? dateOfBirth;
  String? username;
  String? photo;
  String? phoneNumber;
  String? firstName;
  String? email;
  String? sex;
  String? lastName;

  String get fullname =>
      firstName!.toUpperCase() + " " + lastName!.toUpperCase();

  User({
    this.dateOfBirth,
    this.username,
    this.photo,
    this.phoneNumber,
    this.firstName,
    this.email,
    this.sex,
    this.lastName,
  });

  User.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['dateOfBirth'];
    username = json['username'];
    photo = json['photo'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    email = json['email'];
    sex = json['sex'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateOfBirth'] = this.dateOfBirth;
    data['username'] = this.username;
    data['photo'] = this.photo;
    data['phoneNumber'] = this.phoneNumber;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Principle {
  bool? credentialsNonExpired;
  bool? enabled;
  int? id;
  Null password;
  String? username;

  Principle(
      {this.credentialsNonExpired,
      this.enabled,
      this.id,
      this.password,
      this.username});

  Principle.fromJson(Map<String, dynamic> json) {
    credentialsNonExpired = json['credentialsNonExpired'];
    enabled = json['enabled'];
    id = json['id'];
    password = json['password'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['enabled'] = this.enabled;
    data['id'] = this.id;
    data['password'] = this.password;
    data['username'] = this.username;
    return data;
  }
}
