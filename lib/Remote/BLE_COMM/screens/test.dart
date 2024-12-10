// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BLEScreen extends StatefulWidget {
//   @override
//   _BLEScreenState createState() => _BLEScreenState();
// }

// class _BLEScreenState extends State<BLEScreen> {
//   FlutterBluePlus flutterBlue = FlutterBluePlus();
//   BluetoothDevice? connectedDevice;
//   List<ScanResult> scanResults = [];
//   List<BluetoothService> services = [];
//   Map<String, String> sensorData = {};

//   // Sensor characteristic UUIDs
//   static const String CHARACTERISTIC_ACCEL_X_UUID = "dc2ddfce-07a1-4cd9-b53a-0c9461dd2e4d";
//   static const String CHARACTERISTIC_ACCEL_Y_UUID = "2434c5cd-9af9-4c20-9f6c-ed569283adb5";
//   static const String CHARACTERISTIC_ACCEL_Z_UUID = "442f145b-195d-4c97-b601-731700c36aa5";
//   static const String CHARACTERISTIC_GYRO_X_UUID = "4c77c0a5-dbd2-44fd-8a8a-655fa880039b";
//   static const String CHARACTERISTIC_GYRO_Y_UUID = "4dda858f-1ee8-49f4-b7a3-b4fba86fab5a";
//   static const String CHARACTERISTIC_GYRO_Z_UUID = "9186d23f-cd46-476c-bdcc-cba3536cc490";

//   double accelX = 0.0, accelY = 0.0, accelZ = 0.0;
//   double gyroX = 0.0, gyroY = 0.0, gyroZ = 0.0;

//   // Posture thresholds
//   final double forwardBendingThreshold = 30.0; // degrees for slouching
//   final double lateralTiltThreshold = 15.0; // degrees for side tilting

//   int bendingLevel = 1; // Bending level from 1 to 3

//   @override
//   void initState() {
//     super.initState();
//     startScan();
//   }

//   void startScan() async {
//     setState(() {
//       scanResults.clear();
//     });
//     FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
//     FlutterBluePlus.scanResults.listen((results) {
//       setState(() {
//         scanResults = results;
//       });
//     });
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     setState(() {
//       connectedDevice = device;
//     });
//     await device.connect();
//     discoverServices();
//   }

//   void discoverServices() async {
//     if (connectedDevice != null) {
//       services = await connectedDevice!.discoverServices();
//       listenToCharacteristics();
//     }
//   }

//   void listenToCharacteristics() {
//     for (BluetoothService service in services) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         final uuid = characteristic.uuid.toString();
//         if ([CHARACTERISTIC_ACCEL_X_UUID, CHARACTERISTIC_ACCEL_Y_UUID, CHARACTERISTIC_ACCEL_Z_UUID,
//              CHARACTERISTIC_GYRO_X_UUID, CHARACTERISTIC_GYRO_Y_UUID, CHARACTERISTIC_GYRO_Z_UUID]
//             .contains(uuid)) {
//           characteristic.setNotifyValue(true);
//           characteristic.value.listen((value) {
//             if (mounted) {
//               setState(() {
//                 sensorData[uuid] = String.fromCharCodes(value);
//                 processSensorData(uuid, value);
//               });
//             }
//           });
//         }
//       }
//     }
//   }

//   void processSensorData(String uuid, List<int> value) {
//     if (uuid == CHARACTERISTIC_ACCEL_X_UUID) {
//       accelX = convertToFloat(value);
//     } else if (uuid == CHARACTERISTIC_ACCEL_Y_UUID) {
//       accelY = convertToFloat(value);
//     } else if (uuid == CHARACTERISTIC_ACCEL_Z_UUID) {
//       accelZ = convertToFloat(value);
//     } else if (uuid == CHARACTERISTIC_GYRO_X_UUID) {
//       gyroX = convertToFloat(value);
//     } else if (uuid == CHARACTERISTIC_GYRO_Y_UUID) {
//       gyroY = convertToFloat(value);
//     } else if (uuid == CHARACTERISTIC_GYRO_Z_UUID) {
//       gyroZ = convertToFloat(value);
//     }

//     calculatePosture();
//   }

//   double convertToFloat(List<int> value) {
//     // Convert the raw sensor value to a float (assuming 2 bytes for each value)
//     return (value[0] | (value[1] << 8)).toDouble();
//   }

//   void calculatePosture() {
//     // Calculate the angles of the body using accelerometer data
//     double totalAcceleration = sqrt(accelX * accelX + accelY * accelY + accelZ * accelZ);
//     double pitch = acos(accelZ / totalAcceleration) * (180 / pi); // Angle in degrees

//     double lateralTilt = atan2(accelY, accelX) * (180 / pi); // Lateral tilt in degrees

//     String postureStatus = "Good Posture";
//     int newBendingLevel = 1;

//     // Check bending level based on the pitch angle
//     if (pitch > forwardBendingThreshold) {
//       newBendingLevel = 3; // Worst posture (too much bending)
//     } else if (pitch > 10.0) {
//       newBendingLevel = 2; // Moderate bending
//     }

//     if (lateralTilt.abs() > lateralTiltThreshold) {
//       postureStatus = "Bad Posture (Lateral Tilt)";
//     }

//     setState(() {
//       bendingLevel = newBendingLevel;
//     });

//     // Show posture status and bending level
//     print("Posture: $postureStatus, Bending Level: $bendingLevel");
//   }

//   void disconnectDevice() async {
//     await connectedDevice?.disconnect();
//     setState(() {
//       connectedDevice = null;
//       services.clear();
//       sensorData.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("BLE Device Scanner")),
//       body: connectedDevice == null
//           ? buildDeviceList()
//           : buildConnectedDeviceView(),
//     );
//   }

//   Widget buildDeviceList() {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: startScan,
//           child: Text("Scan for Devices"),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: scanResults.length,
//             itemBuilder: (context, index) {
//               final result = scanResults[index];
//               return ListTile(
//                 title: Text(result.device.name.isNotEmpty
//                     ? result.device.name
//                     : "Unknown Device"),
//                 subtitle: Text(result.device.id.toString()),
//                 onTap: () => connectToDevice(result.device),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildConnectedDeviceView() {
//     return ListView(
//       children: [
//         ListTile(
//           title: Text("Connected to ${connectedDevice!.name}"),
//         ),
//         ElevatedButton(
//           onPressed: disconnectDevice,
//           child: Text("Disconnect"),
//         ),
//         Divider(),
//         buildSensorDataRow("Accel X", CHARACTERISTIC_ACCEL_X_UUID),
//         buildSensorDataRow("Accel Y", CHARACTERISTIC_ACCEL_Y_UUID),
//         buildSensorDataRow("Accel Z", CHARACTERISTIC_ACCEL_Z_UUID),
//         buildSensorDataRow("Gyro X", CHARACTERISTIC_GYRO_X_UUID),
//         buildSensorDataRow("Gyro Y", CHARACTERISTIC_GYRO_Y_UUID),
//         buildSensorDataRow("Gyro Z", CHARACTERISTIC_GYRO_Z_UUID),
//         Divider(),
//         // Display bending level
//         ListTile(
//           title: Text("Bending Level"),
//           subtitle: Text(bendingLevel == 1
//               ? "Normal (Posture is good)"
//               : bendingLevel == 2
//                   ? "Moderate Bending"
//                   : "Severe Bending (Bad Posture)"),
//         ),
//       ],
//     );
//   }

//   Widget buildSensorDataRow(String label, String uuid) {
//     return ListTile(
//       title: Text(label),
//       subtitle: Text(sensorData[uuid] ?? "No data"),
//     );
//   }

//   @override
//   void dispose() {
//     connectedDevice?.disconnect();
//     super.dispose();
//   }
// }
