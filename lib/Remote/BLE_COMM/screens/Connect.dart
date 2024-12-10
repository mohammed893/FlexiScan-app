import 'package:flexiscan101/Remote/BLE_COMM/controllers/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connected Device")),
      body: BlocBuilder<BleCubit, BleState>(
        builder: (context, state) {
          if (state.connectedDevice == null) {
            return const Center(child: Text("No device connected"));
          }

          return ListView(
            children: [
              ListTile(title: Text("Connected to ${state.connectedDevice!.name}")),
              ElevatedButton(
                onPressed: () {
                  context.read<BleCubit>().disconnectDevice();
                  Navigator.pop(context);
                },
                child: const Text("Disconnect"),
              ),
              const Divider(),
              ...state.sensorData.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text(entry.value),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
