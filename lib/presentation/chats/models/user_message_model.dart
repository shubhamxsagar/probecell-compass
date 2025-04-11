class UserMessageModel {
  List<Messages>? messages;

  UserMessageModel({this.messages});

  UserMessageModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
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
