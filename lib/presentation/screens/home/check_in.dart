import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_attendance_system/presentation/screens/home/cubits/employee_location_cubit.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/buttons.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/company_location.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/details_card.dart';

import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';


class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();

  }

  // Request location permission

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Location permission denied');
    } else {

      await EmployeeLocationCubit.get(context).checkEmployeeLocation();

    }
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // Check in
  Future<void> _checkIn() async {
    bool isInside =
        await EmployeeLocationCubit.get(context).checkEmployeeLocation();
    if (isInside) {
      await EmployeeLocationCubit.get(context).checkIn();
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<EmployeeLocationCubit, EmployeeLocationState>(
            listener: (context, state) {
              if (state is EmployeeLocationError) {
                CustomSnackBar.show(
                  context,
                  state.message,
                  color: chooseSnackBarColor(ToastStates.ERROR),
                );
              } else if (state is EmployeeLocationOutside) {
                CustomSnackBar.show(
                  context,
                  state.message,
                  color: chooseSnackBarColor(ToastStates.ERROR),
                );
              } else if (state is EmployeeCheckedIn) {
                CustomSnackBar.show(
                  context,
                  'Checked In Successfully at ${state.time}',
                  color: chooseSnackBarColor(ToastStates.SUCCESS),
                );
              }
            },
            builder: (context, state) {
              bool isInside = state is EmployeeLocationInside;
              final String checkInTime =
                  (state is EmployeeCheckedIn) ? state.time : 'Not Checked In';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckInOutButton(
                        label: 'Check In',
                        color:
                            isInside ? const Color(0XFF2563EB) : Colors.black12,
                        onPressed: _checkIn,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CheckInOutButton(
                        label: 'Check Out',
                        color: const Color(0XFF203546),
                        onPressed: _checkIn,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Today's Attendance",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Detailscard(
                        title: 'Check In',
                        subtitle: checkInTime,
                        icon: Icons.login,
                        iconColor: const Color(0xff203546),
                      ),
                      const Detailscard(
                        title: 'Check In',
                        subtitle: '10:00',
                        icon: Icons.login,
                        iconColor: Color(0xff203546),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CompanyLocation(),
                ],
              );
            },
          ),
        ),

      ),
    );
  }
}
