
class LoginModel{
  String status;
  String? message;
  String? token;


  LoginModel({
    required this.status,
    required this.token,
    required this.message,

  });

  factory LoginModel.fromJson(Map<String,dynamic>json){
    return LoginModel(
        status: json['status'] as String,
        message: json['message'] as String?,
        token: json['token']  as String?,
    );
  }
}
