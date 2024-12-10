import 'package:bloc/bloc.dart';
import 'package:flexiscan101/users/Patient/Cubit/cubit.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleState {
  final List<ScanResult> scanResults;
  final BluetoothDevice? connectedDevice;
  final Map<String, String> sensorData;

  BleState({
    this.scanResults = const [],
    this.connectedDevice,
    this.sensorData = const {},
  });
}

class BleCubit extends Cubit<BleState> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  BleCubit() : super(BleState());

  void startScan() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) {
      emit(BleState(scanResults: results, connectedDevice: state.connectedDevice));
    });
  }

  void connectToDevice(BluetoothDevice device , FlexiCubit flexiCubit) async {
    emit(BleState(scanResults: state.scanResults, connectedDevice: device));
    await device.connect();
    discoverServices(device);
    FlexiCubit.BLEConnected = true;
    device.connectionState.listen((event) {
      if (event == BluetoothConnectionState.disconnected) {
        flexiCubit.updateBLEConnection(false);
        // print('DISSSSSSSSSSSSS');
      }
    },);
  }

  void disconnectDevice() async {
    await state.connectedDevice?.disconnect();
    FlexiCubit.BLEConnected = false;
    emit(BleState(scanResults: state.scanResults));
    
  }

  void discoverServices(BluetoothDevice device) async {
    final services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        await characteristic.setNotifyValue(true);
        characteristic.value.listen((value) {
          final uuid = characteristic.uuid.toString();
          final updatedSensorData = Map<String, String>.from(state.sensorData)
            ..[uuid] = String.fromCharCodes(value);
          emit(BleState(
            scanResults: state.scanResults,
            connectedDevice: device,
            sensorData: updatedSensorData,
          ));
        });
      }
    }
  }
}
