part of 'employee_location_cubit.dart';

@immutable
abstract class EmployeeLocationState {}

class EmployeeLocationInitial extends EmployeeLocationState {}

class EmployeeLocationInside extends EmployeeLocationState {

  EmployeeLocationInside({required this.checkInTime, required this.isOnTime});

  final DateTime checkInTime;
  final bool isOnTime;
}

class EmployeeLocationOutside extends EmployeeLocationState {
  EmployeeLocationOutside(this.message);

  final String message;
}


class EmployeeLocationPermissionDenied extends EmployeeLocationState {}

class EmployeeCheckedIn extends EmployeeLocationState {

  EmployeeCheckedIn({required this.time});

  final String time;
}

class EmployeeLocationError extends EmployeeLocationState {
  EmployeeLocationError(this.message);

  final String message;
}

