class NotiModel {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  Null? readAt;
  String? createdAt;
  String? updatedAt;

  NotiModel(
      {this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  NotiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  String? title;
  String? message;

  Data({this.title, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}
