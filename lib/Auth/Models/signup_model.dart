 class SignupModel{
   String status;
   String message;
   String? token;

   SignupModel({
     required this.status,
     required this.token,
     required this.message,
 });

   factory SignupModel.fromJson(Map<String , dynamic>json){
     return SignupModel(
       status: json['status'] as String,
       message: json['message'] as String,
       token: json['token']  as String?,
     );
   }
 }


