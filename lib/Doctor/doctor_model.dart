// Doctor/doctor_model.dart
class DoctorModel {
  String? name;
  String? hospital;
  String? specialization;
  String? profilePic;
  String? phoneNumber;

  DoctorModel({
    required this.name,
    required this.hospital,
    required this.specialization,
    this.profilePic,
    this.phoneNumber,
  });

  bool isComplete() {
    return name != null && hospital != null && specialization != null;
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'],
      hospital: json['hospital'],
      specialization: json['specialization'],
      profilePic: json['profilePic'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hospital': hospital,
      'specialization': specialization,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
    };
  }
}
