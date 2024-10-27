 class BoardingModel{
  String image;
  String title;
  String body;
  String? image2;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
    this.image2,
 }
 );
 }

 List<BoardingModel> boarding =  [
   BoardingModel(
       image: 'asset/images/Doctor.png',
       image2: 'asset/images/Doctor.png',
       title: 'Doctors Branch',
       body:  ' Easily connect with patients for virtual sessions and access Ai fo enhance every treatment plan.'
   ),
   BoardingModel(
       image: 'asset/images/Removal-683.png',
       title: 'Patients Branch',
       body:  'Book personalized physical therapy sessions and track your progress.'
   ),
   BoardingModel(
       image: 'asset/images/Idle.gif',
       title: 'Flexi',
       body:  'Flexi is here to support your wellness journey with expert care and smart Ai features. '
   ),

 ];