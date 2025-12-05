class DetailComplaintModel {
  bool? status;
  ComplaintData? complaintData;
  String? message;

  DetailComplaintModel({this.status, this.complaintData, this.message});

  DetailComplaintModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    complaintData = json['data'] != null ? new ComplaintData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.complaintData != null) {
      data['data'] = this.complaintData!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ComplaintData {
  int? id;
  String? type;
  int? status;
  String? description;
  String? location;
  String? createdAt;
  Company? company;
  User? user;
  Null? employee;
  List<String>? attachments;

  ComplaintData(
      {this.id,
        this.type,
        this.status,
        this.description,
        this.location,
        this.createdAt,
        this.company,
        this.user,
        this.employee,
        this.attachments});

  ComplaintData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    description = json['description'];
    location = json['location'];
    createdAt = json['created_at'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    employee = json['employee'];
    attachments = json['attachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['description'] = this.description;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['employee'] = this.employee;
    data['attachments'] = this.attachments;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? location;

  Company({this.id, this.name, this.location});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    return data;
  }
}

class User {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? phone;

  User({this.id, this.fullname, this.username, this.email, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
