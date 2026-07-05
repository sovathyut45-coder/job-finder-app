class AppliedJobModel {
    final int id;

  final String jobId;

  final String title;

  final String company;

  final String location;

  final String? logo;

  final String url;

  final String status;

  final String notes;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  AppliedJobModel({
    required this.id,
    required this.jobId,
    required this.title,
    required this.company,
    required this.location,
    required this.logo,
    required this.url,
    required this.status,
    required this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory AppliedJobModel.fromJson(Map<String, dynamic> json) {
    return AppliedJobModel(
      id: json['id'],
      jobId: json['job_id'],
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      logo: json['logo'] ?? '',
      url: json['url']?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'title': title,
      'company': company,
      'location': location,
      'logo': logo,
      'url': url,
      'status': status,
      'notes': notes,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  AppliedJobModel copyWith({
    int? id,
    String? jobId,
    String? title,
    String? company,
    String? location,
    String? logo,
    String? url,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppliedJobModel(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      logo: logo ?? this.logo,
      url: url ?? this.url,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}