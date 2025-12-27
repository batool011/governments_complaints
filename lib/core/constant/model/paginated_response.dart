import 'package:governments_complaints/core/constant/model/meta_Model.dart';

class PaginatedResponse<T> {
  final List<T> items;
  final MetaModel meta;

  PaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return PaginatedResponse(
      items: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      meta: MetaModel.fromJson(json['meta'] ?? {}),
    );
  }
}