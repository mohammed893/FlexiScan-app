// Patient/patient_model.dart
class PatientModel {
  String? name;
  int? age;
  String? gender;
  String? profilePic;
  String? address;

  PatientModel({
    required this.name,
    required this.age,
    required this.gender,
    this.profilePic,
    this.address,
  });

  bool isComplete() {
    return name != null && age != null && gender != null;
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      profilePic: json['profilePic'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'profilePic': profilePic,
      'address': address,
    };
  }
}
