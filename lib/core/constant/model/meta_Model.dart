class MetaModel {
  final int currentPage;
  final int perPage;
  final int total;
  final int totalPages;

  MetaModel({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] ?? 1,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
