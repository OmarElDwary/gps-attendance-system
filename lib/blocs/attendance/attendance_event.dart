import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object?> get props => [];
}

class CheckInRequested extends AttendanceEvent {}

class CheckOutRequested extends AttendanceEvent {}
