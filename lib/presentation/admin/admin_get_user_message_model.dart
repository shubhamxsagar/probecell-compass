class AdminGetUserMessageModel {
  User? user;
  List<Messages>? messages;

  AdminGetUserMessageModel({this.user, this.messages});

  AdminGetUserMessageModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
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

  User(
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

class Messages {
  int? id;
  int? userId;
  int? sentByUser;
  String? message;
  String? files;
  String? createdAt;
  String? updatedAt;
  String? fileUrl;

  Messages(
      {this.id,
      this.userId,
      this.sentByUser,
      this.message,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.fileUrl});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sentByUser = json['sent_by_user'];
    message = json['message'];
    files = json['files'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['sent_by_user'] = this.sentByUser;
    data['message'] = this.message;
    data['files'] = this.files;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
