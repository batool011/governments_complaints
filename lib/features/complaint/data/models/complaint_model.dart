import 'package:governments_complaints/core/constant/class/typedef.dart';

class ComplaintModel {
  final int? id;
  final String type; 
  final String companyId; 
  final String description; 
  final String location; 
  final List<String> attachments; 
  final String? status; 
  final String? referenceNumber; 
  final DateTime? createdAt; 
  final CompanyModel? company; 

  ComplaintModel({
    this.id,
    required this.type, 
    required this.companyId, 
    required this.location, 
    required this.description,
    required this.attachments,
    this.status,
    this.referenceNumber,
    this.createdAt,
    this.company, 
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type, 
      'company_id': companyId, 
      'description': description,
      'location': location, 
      'attachments': attachments,
      'status': status,
      'reference_number': referenceNumber,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      type: json['type'] ?? '', 
      companyId: json['company_id']?.toString() ?? '', 
      location: json['location'] ?? '', 
      description: json['description'],
      attachments: json['attachments'] != null 
          ? List<String>.from(json['attachments'])
          : <String>[],
      status: json['status'],
      referenceNumber: json['reference_number'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
      company: json['company'] != null 
          ? CompanyModel.fromJson(json['company'])
          : null, 
    );
  }
}



class CompanyModel {
  final int id;
  final String name;
  final String? location;

  CompanyModel({
    required this.id,
    required this.name,
    this.location,
  });

  DynamicMap toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }

  factory CompanyModel.fromJson(DynamicMap json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'],
    );
  }
}
