class SearchHistoryModel {
  List<SearchHistory>? searchHistory;

  SearchHistoryModel({this.searchHistory});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['search_history'] != null) {
      searchHistory = <SearchHistory>[];
      json['search_history'].forEach((v) {
        searchHistory!.add(new SearchHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchHistory != null) {
      data['search_history'] =
          this.searchHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchHistory {
  int? id;
  int? userId;
  int? typeOfWorkId;
  int? courseId;
  int? areaId;
  int? categoryId;
  int? subCategoryId;
  String? aiResponse;
  String? createdAt;
  String? updatedAt;

  SearchHistory(
      {this.id,
      this.userId,
      this.typeOfWorkId,
      this.courseId,
      this.areaId,
      this.categoryId,
      this.subCategoryId,
      this.aiResponse,
      this.createdAt,
      this.updatedAt});

  SearchHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeOfWorkId = json['type_of_work_id'];
    courseId = json['course_id'];
    areaId = json['area_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    aiResponse = json['ai_response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type_of_work_id'] = this.typeOfWorkId;
    data['course_id'] = this.courseId;
    data['area_id'] = this.areaId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['ai_response'] = this.aiResponse;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
