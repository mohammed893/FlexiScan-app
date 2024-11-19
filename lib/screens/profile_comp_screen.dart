// screens/profile_comp_screen.dart
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Doctor/doctor_model.dart';
import 'package:flexiscan101/Patient/patient_model.dart';
import 'package:flexiscan101/shared/profile/cubit.dart';
import 'package:flexiscan101/shared/profile/states.dart';
import 'package:flexiscan101/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteInformationScreen extends StatelessWidget {
  final String userType; // "patient" or "doctor"

  CompleteInformationScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController(); // For patient
  final TextEditingController genderController = TextEditingController(); // For patient
  final TextEditingController specializationController = TextEditingController(); // For doctor
  final TextEditingController hospitalController = TextEditingController(); // For doctor

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileCompleteState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Complete Your Information',
              style: TextStyle(
                 color: AppColors.lightTextandicon,
                 fontWeight: FontWeight.w600,
                 ),
              ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: 
                Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your name' : null,
                      ),
                      if (userType == 'patient') ...[
                        TextFormField(
                          controller: ageController,
                          decoration: InputDecoration(labelText: 'Age'),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your age' : null,
                        ),
                        TextFormField(
                          controller: genderController,
                          decoration: InputDecoration(labelText: 'Gender'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your gender' : null,
                        ),
                      ],
                      if (userType == 'doctor') ...[
                        TextFormField(
                          controller: specializationController,
                          decoration: InputDecoration(labelText: 'Specialization'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your specialization' : null,
                        ),
                        TextFormField(
                          controller: hospitalController,
                          decoration: InputDecoration(labelText: 'Hospital'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your hospital' : null,
                        ),
                      ],
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your phone number' : null,
                      ),
                      const SizedBox(height: 20),
                      buildButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            if (userType == 'patient') {
                              final patientModel = PatientModel(
                                name: nameController.text,
                                age: int.tryParse(ageController.text),
                                gender: genderController.text,
                              );
                              ProfileCubit.get(context)
                                  .updatePatientProfile(patientModel);
                            } else if (userType == 'doctor') {
                              final doctorModel = DoctorModel(
                                name: nameController.text,
                                hospital: hospitalController.text,
                                specialization: specializationController.text,
                                phoneNumber: phoneController.text,
                              );
                              ProfileCubit.get(context)
                                  .updateDoctorProfile(doctorModel);
                            }
                          }
                        },
                       color: AppColors.darkBackground ,
                       text: 'submit',
                       width: 150 ,
                       height: 30 ,
                       textColor: Colors.white
                      ),
                    ],
                  ),
                ),
              
            ),
          ),
        );
      },
    );
  }
}
