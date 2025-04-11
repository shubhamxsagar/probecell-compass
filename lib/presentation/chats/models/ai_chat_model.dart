class AiChatModel {
  String? message;
  Data? data;

  AiChatModel({this.message, this.data});

  AiChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? aiResponse;

  Data({this.aiResponse});

  Data.fromJson(Map<String, dynamic> json) {
    aiResponse = json['ai_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ai_response'] = this.aiResponse;
    return data;
  }
}
