
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlexiCubit,FlexiStates>(
      listener: (context , state){},
      builder: (context , state){
        var flexi = FlexiCubit.get(context).devices ;
        return Scaffold(
          body: Text('hello'),
        );
      },
    );
  }
}