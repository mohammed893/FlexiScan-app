import 'package:flexiscan101/Remote/BLE_COMM/controllers/cubit.dart';
import 'package:flexiscan101/Remote/BLE_COMM/screens/Connect.dart';
import 'package:flexiscan101/users/Patient/Cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("BLE Scanner")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.read<BleCubit>().startScan(),
            child: const Text("Scan for Devices"),
          ),
          Expanded(
            child: BlocBuilder<BleCubit, BleState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.scanResults.length,
                  itemBuilder: (context, index) {
                    final result = state.scanResults[index];
                    return ListTile(
                      title: Text(result.device.name.isNotEmpty
                          ? result.device.name
                          : "Unknown Device"),
                      subtitle: Text(result.device.id.toString()),
                      onTap: () {
                        context.read<BleCubit>().connectToDevice(result.device , FlexiCubit.get(context));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ConnectedScreen()),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
