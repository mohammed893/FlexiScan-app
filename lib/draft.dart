// buildFormFiled(label: 'Phone Number',
// color: Color(0xffffd691),
// radius: 20,
// ),
// SizedBox(height: 25,),
// buildFormFiled(label: 'Age',
// color: Color(0xffffd691),
// radius: 20),
// SizedBox(height: 25,),
// buildDateFiled(context),
// SizedBox(height: 25,),



// Widget buildDateFiled(context){
//   return buildFormFiled(
//       label: 'Date Of Birth',
//       controller: dateController,
//       validator:(value){
//         if(value == null || value.isEmpty){
//           return ' Pleas set a date';
//         }
//         return null;
//       },
//       suffix: Icons.calendar_month_rounded,
//       iconColor: Color(0xff233a66),
//       color: Color(0xffffd691),
//       onTap: () async{
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate:DateTime.now() ,
//           firstDate: DateTime.now(),
//           lastDate:DateTime(2030, 12, 31),
//         );
//         if(pickedDate !=null){
//           dateController.text=
//           "${pickedDate.day}/${pickedDate
//               .month}/${pickedDate.year}";
//         }
//       }
//
//
//   );
// }
