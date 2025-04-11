class UserInfoModel {
  UserInfo? userInfo;

  UserInfoModel({this.userInfo});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? isEmailVerified;
  String? otp;
  String? otpExpiresAt;
  int? isBlocked;
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.isEmailVerified,
      this.otp,
      this.otpExpiresAt,
      this.isBlocked,
      this.createdAt,
      this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    isEmailVerified = json['is_email_verified'];
    otp = json['otp'];
    otpExpiresAt = json['otp_expires_at'];
    isBlocked = json['is_blocked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['is_email_verified'] = this.isEmailVerified;
    data['otp'] = this.otp;
    data['otp_expires_at'] = this.otpExpiresAt;
    data['is_blocked'] = this.isBlocked;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
