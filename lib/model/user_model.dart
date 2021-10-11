class User {
  String? userId;
  String? name;
  String? contactNo;
  String? deviceId;
  String? userLanguage;

User({
  this.userId,
  this.name,
  this.contactNo,
  this.deviceId,
  this.userLanguage,
});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    contactNo = json['contactNo'];
    deviceId = json['deviceId'];
    userLanguage = json['userLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['contactNo'] = this.contactNo;
    data['deviceId'] = this.deviceId;
    data['userLanguage'] = this.userLanguage;
    return data;
  }
}
