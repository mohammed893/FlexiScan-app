
import 'package:flexiscan101/users/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/users/Patient/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlexiCubit,FlexiStates>(
      listener: (context , state){},
      builder: (context , state){
        var flexi = FlexiCubit.get(context) ;
        return Scaffold(
          body: Text('hello'),
        );
      },
    );
  }
}