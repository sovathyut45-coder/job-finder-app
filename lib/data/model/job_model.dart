class JobModel {
  final String jobId;
  final String jobTitle;
  final String employerName;
  final String employerLogo;

  final String jobLocation;
  final String jobCity;
  final String jobCountry;

  final String employmentType;

  final String description;

  final String applyLink;

  final int minSalary;
  final int maxSalary;

  JobModel({
    required this.jobId,
    required this.jobTitle,
    required this.employerName,
    required this.employerLogo,
    required this.jobLocation,
    required this.jobCity,
    required this.jobCountry,
    required this.employmentType,
    required this.description,
    required this.applyLink,
    required this.minSalary,
    required this.maxSalary,
  });

  factory JobModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return JobModel(
      jobId: json['job_id'] ?? '',
      jobTitle: json['job_title'] ?? '',
      employerName: json['employer_name'] ?? '',
      employerLogo: json['employer_logo'] ?? '',
      jobLocation: json['job_location'] ?? '',
      jobCity: json['job_city'] ?? '',
      jobCountry: json['job_country'] ?? '',
      employmentType:
          json['job_employment_type'] ?? '',
      description:
          json['job_description'] ?? '',
      applyLink:
          json['job_apply_link'] ?? '',
      minSalary:
           int.tryParse(json['job_min_salary'].toString()) ?? 0,
      maxSalary:
           int.tryParse(json['job_max_salary'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'job_id': jobId,
        'job_title': jobTitle,
        'employer_name': employerName,
        'employer_logo': employerLogo,
        'job_location': jobLocation,
        'job_city': jobCity,
        'job_country': jobCountry,
        'job_employment_type': employmentType,
        'job_description': description,
        'job_apply_link': applyLink,
        'job_min_salary': minSalary,
        'job_max_salary': maxSalary,
      };
}