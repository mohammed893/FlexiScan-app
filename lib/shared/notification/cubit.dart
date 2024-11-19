// shared/notification/cubit.dart
import 'package:flexiscan101/shared/notification/notification_helper.dart';
import 'package:flexiscan101/shared/notification/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  void sendNotification(String title, String body, String payload) async {
    
    await NotificationHelper.showNotification(
      title: title,
      body: body,
      payload: payload,
    );
    emit(NotificationSent());
  }

  void handleNotification(String payload) {
    
    emit(NotificationOpened());
  }
}
