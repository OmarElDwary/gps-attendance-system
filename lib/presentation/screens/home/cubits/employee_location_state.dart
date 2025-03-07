part of 'employee_location_cubit.dart';

@immutable
abstract class EmployeeLocationState {}

class EmployeeLocationInitial extends EmployeeLocationState {}

class EmployeeLocationInside extends EmployeeLocationState {
  final DateTime checkInTime;
  final bool isOnTime;

  EmployeeLocationInside({required this.checkInTime, required this.isOnTime});
}

class EmployeeLocationOutside extends EmployeeLocationState {}

class EmployeeLocationPermissionDenied extends EmployeeLocationState {}

class EmployeeCheckedIn extends EmployeeLocationState {
  final String time;
  EmployeeCheckedIn({required this.time});
}

class EmployeeLocationError extends EmployeeLocationState {
  final String message;
  EmployeeLocationError(this.message);
}