// shared/notification/states.dart
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSent extends NotificationState {}

class NotificationOpened extends NotificationState {}
