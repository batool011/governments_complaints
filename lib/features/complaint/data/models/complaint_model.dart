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
    print('🔄 Parsing ComplaintModel from JSON: $json');
    
    
    String companyId = '';
    if (json['company'] != null && json['company']['id'] != null) {
      companyId = json['company']['id'].toString();
      print(' Got companyId from company object: $companyId');
    } else if (json['company_id'] != null) {
      companyId = json['company_id'].toString();
      print(' Got companyId from company_id field: $companyId');
    } else {
      print(' No companyId found in response');
    }

    return ComplaintModel(
      id: json['id'],
      type: json['type'] ?? 'Unknown Type',
      companyId: companyId,
      location: json['location'] ?? 'Unknown Location',
      description: json['description'] ?? 'No Description',
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

  @override
  String toString() {
    return 'ComplaintModel(id: $id, type: $type, companyId: $companyId, location: $location)';
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
    print('🔄 Parsing CompanyModel from JSON: $json');
    
    return CompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Company',
      location: json['location'],
    );
  }

  @override
  String toString() {
    return 'CompanyModel(id: $id, name: $name, location: $location)';
  }
}