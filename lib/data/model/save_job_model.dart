class SavedJobModel {
  final int id;

  final String jobId;

  final String title;

  final String company;

  final String location;

  final String jobType;

  final String logo;

  final String url;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  SavedJobModel({
    required this.id,
    required this.jobId,
    required this.title,
    required this.company,
    required this.location,
    required this.jobType,
    required this.logo,
    required this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory SavedJobModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SavedJobModel(
      id: json['id'] ?? 0,

      jobId: json['job_id'] ?? '',

      title: json['title'] ?? '',

      company: json['company'] ?? '',

      location: json['location'] ?? '',

      jobType: json['job_type'] ?? '',

      logo: json['logo'] ?? '',

      url: json['url'] ?? '',

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'title': title,
      'company': company,
      'location': location,
      'job_type': jobType,
      'logo': logo,
      'url': url,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  SavedJobModel copyWith({
    int? id,
    String? jobId,
    String? title,
    String? company,
    String? location,
    String? jobType,
    String? logo,
    String? url,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SavedJobModel(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      logo: logo ?? this.logo,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}