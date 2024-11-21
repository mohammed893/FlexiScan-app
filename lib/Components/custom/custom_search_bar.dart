import 'package:flexiscan101/shared/app_cubit/app_cubit.dart';
import 'package:flexiscan101/shared/app_cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  final TextEditingController searchController;
  Search({super.key , required this.searchController});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            SearchBar(
              controller: searchController,
              hintText: 'search',
              leading: Icon(Icons.search),
              onChanged:(value){
                // print(value);
                // AppCubit.get(context).getSearch(value);
              },
              onSubmitted: (value) {
                print(value);
              },
            ),
                if (state is GetSearchSuccessState)
            Expanded(
              child: ListView.builder(
                itemCount: AppCubit.get(context).search.length,
                itemBuilder: (context, index) {
                  AppCubit.get(context).search[index];
                  return ListTile(
                    title: Text( AppCubit.get(context).search[index]['title'] ?? 'No title'),
                    subtitle: Text( AppCubit.get(context).search[index]['description'] ?? 'No description'),
                  );
                },
              ),
            ),
                  if (state is NewsGetSearchLoadingState)
            Center(child: CircularProgressIndicator()),
                ],
        );
      },
    );
  }
}

