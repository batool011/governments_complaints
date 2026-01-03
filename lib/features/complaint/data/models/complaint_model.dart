import 'package:governments_complaints/core/constant/class/typedef.dart';



/// Company Model
class CompanyModel {
  final int id;
  final String name;
  final String? location;

  CompanyModel({
    required this.id,
    required this.name,
    this.location,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      location: json['location'],
    );
  }
}

/// User Model
class UserModel {
  final int id;
  final String fullname;
  final String username;
  final String? email;
  final String? phone;

  UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullname: json['fullname'] ?? '',
      username: json['username'] ?? '',
      email: json['email'],
      phone: json['phone'],
    );
  }
}

/// Employee Model (nullable)
class EmployeeModel {
  final int id;
  final String name;

  EmployeeModel({
    required this.id,
    required this.name,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

/// Complaint Model
class ComplaintModel {
  final int? id;
  final String type;
  final int companyId;
  final String description;
  final String location;
  final int? status;
  final DateTime? createdAt;
  final CompanyModel? company;
  final UserModel? user;
  final EmployeeModel? employee;
  final List<String> attachments;

  ComplaintModel({
    this.id,
    required this.type,
    required this.companyId,
    required this.description,
    required this.location,
    this.status,
    this.createdAt,
    this.company,
    this.user,
    this.employee,
    required this.attachments,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      type: json['type'] ?? 'Unknown',
      companyId: json['company']?['id'] ?? json['company_id'] ?? 0,
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      company:
          json['company'] != null ? CompanyModel.fromJson(json['company']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      employee: json['employee'] != null
          ? EmployeeModel.fromJson(json['employee'])
          : null,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'])
          : [],
    );
  }
}



