 class BoardingModel{
  String image;
  String title;
  String body;
  String? image2;
  bool? oneImage;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
    this.image2,
    this.oneImage

 }
 );
 }

 List<BoardingModel> boarding =  [
   BoardingModel(
       image: 'asset/images/Doctor.png',
       image2: 'asset/images/LookingUp.gif',
       title: 'Doctors Branch',
       body:  ' Easily connect with patients for virtual sessions and access Ai fo enhance every treatment plan.',
       oneImage: false
   ),
   BoardingModel(
       image: 'asset/images/Removal-683.png',
       image2: 'asset/images/Pointing.gif',
       title: 'Patients Branch',
       body:  'Book personalized physical therapy sessions and track your progress.',
      oneImage: false

   ),
   BoardingModel(
       image: 'asset/images/Idle.gif',
       title: 'Flexi',
       body:  'Flexi is here to support your wellness journey with expert care and smart Ai features. ',
      oneImage: true

   ),

 ];