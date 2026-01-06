class ComplaintStatusModel {
  final int status;
  final int count;

  ComplaintStatusModel({
    required this.status,
    required this.count,
  });

  factory ComplaintStatusModel.fromJson(Map<String, dynamic> json) {
    return ComplaintStatusModel(
      status: json['status'] ?? 0, 
      count: json['count'] ?? 0,  
    );
  }
}
