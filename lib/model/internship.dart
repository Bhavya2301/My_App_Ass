class InternshipDetails {
  final String id;
  final String jobTitle;
  final List<String> location;
  final String salary;
  final String duration;

  InternshipDetails({
    required this.id,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.duration,
  });

  factory InternshipDetails.fromJson(String id, Map<String, dynamic> json) {
    return InternshipDetails(
      id: id,
      jobTitle: json['title'],
      location: List<String>.from(json['location_names']),
      salary: json['stipend']['salary'],
      duration: json['duration'],
    );
  }
}