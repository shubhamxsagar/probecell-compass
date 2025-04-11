class AdminGetAllMessageModel {
  String? message;
  Map<String, List<Message>>? data;

  AdminGetAllMessageModel({this.message, this.data});

  AdminGetAllMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <String, List<Message>>{};
      json['data'].forEach((key, value) {
        data![key] = (value as List).map((v) => Message.fromJson(v)).toList();
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((key, value) {
        return MapEntry(key, value.map((v) => v.toJson()).toList());
      });
    }
    return data;
  }
}

class Message {
  int? id;
  int? userId;
  int? sentByUser;
  String? message;
  String? files;
  String? createdAt;
  String? updatedAt;
  String? fileUrl;
  User? user;

  Message({
    this.id,
    this.userId,
    this.sentByUser,
    this.message,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.fileUrl,
    this.user,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sentByUser = json['sent_by_user'];
    message = json['message'];
    files = json['files'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fileUrl = json['file_url'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['sent_by_user'] = sentByUser;
    data['message'] = message;
    data['files'] = files;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['file_url'] = fileUrl;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
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

  User({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isEmailVerified,
    this.otp,
    this.otpExpiresAt,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['is_email_verified'] = isEmailVerified;
    data['otp'] = otp;
    data['otp_expires_at'] = otpExpiresAt;
    data['is_blocked'] = isBlocked;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}