import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/blocs/user_cubit/users_cubit.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_container.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_list_tile.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/users_list.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

DateTime date = DateTime.now();
//format using intl package
DateFormat format = DateFormat('EEE, dd MMM');

String formattedDate = format.format(date);

// constant data
//------------ Dummy data ---------//
final List<UserModel> dummyUsersObjects = [
  UserModel(
    name: 'Noura Tarek',
    email: 'noura@gmail.com',
    contactNumber: '011455555',
    isOnLeave: false,
    role: Role.employee,
    position: 'Software Engineer',
  ),
  UserModel(
    name: 'Ahmed Tarek',
    email: 'ahmed@gmail.com',
    contactNumber: '011455555',
    isOnLeave: false,
    role: Role.employee,
    position: 'Software Engineer',
  ),
  UserModel(
    name: 'John doe',
    email: 'john@gmail.com',
    contactNumber: '011455555',
    isOnLeave: false,
    role: Role.employee,
    position: 'Software Engineer',
  ),
];

/////////
class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  final TextEditingController searchController = TextEditingController();
  final List<String> containerTitles = [
    AppStrings.totalAttendance,
    AppStrings.employeesPresentNow,
    AppStrings.totalLeaves,
    AppStrings.pendingApprovals,
  ];

  final List<String> headerTitles = [
    AppStrings.dashboard,
    AppStrings.employees,
    AppStrings.managers,
    AppStrings.geofence,
    AppStrings.profile,
    AppStrings.leaves,
    AppStrings.settings,
    AppStrings.logout,
  ];

  final List<IconData> headerIcons = [
    Icons.dashboard,
    Icons.person,
    Icons.supervisor_account,
    Icons.location_on,
    Icons.person,
    Icons.calendar_month,
    Icons.settings,
    Icons.logout,
  ];
  final List<IconData> containerIcons = [
    Icons.how_to_reg,
    Icons.group,
    Icons.calendar_month,
    Icons.pending_actions,
  ];

  @override
  Widget build(BuildContext context) {
    UsersCubit usersCubit = UsersCubit.get(context);
    return Scaffold(
      // App bar
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      // Drawer
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer header includes title and date
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Admin name
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Today Date
                        Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        // Admin name
                        BlocBuilder<UsersCubit, UsersState>(
                          builder: (context, state) {
                            UserModel? admin = usersCubit.adminData;
                            return Text(
                              'Hello, ${admin?.name ?? "Admin"}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Admin photo
                  const CircleAvatar(
                    backgroundColor: AppColors.whiteColor,
                    radius: 26,
                  ),
                ],
              ),
            ),
            // Dashboard list tiles
            // closes the drawer if the required page is opened
            ...List.generate(
              headerTitles.length,
              (index) {
                return CustomListTile(
                  isUser: false,
                  title: headerTitles[index],
                  leadingWidget: Icon(
                    headerIcons[index],
                  ),
                  onTap: () {
                    if (index == 0) {
                      Navigator.pop(context);
                    } else if (index == 1) {
                      Navigator.pushNamed(
                        // we will send the employees list from firebase
                        // to the employees page
                        arguments: UsersCubit.get(context).employees,
                        context,
                        AppRoutes.employees,
                      );
                    } else if (index == 2) {
                      Navigator.pushNamed(
                        // we will send the managers list from firebase
                        // to the mangers page
                        arguments: UsersCubit.get(context).managers,
                        context,
                        AppRoutes.managers,
                      );
                    } else if (index == 3) {
                      Navigator.pushNamed(context, AppRoutes.geofence);
                    } else if (index == 4) {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    } else if (index == 5) {
                      Navigator.pushNamed(context, AppRoutes.leaves);
                    } else if (index == 6) {
                      Navigator.pushNamed(context, AppRoutes.settings);
                    } else {
                      // log out logic here
                      AuthCubit.get(context).logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        (_) => false,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(12),
        child: ListView(
          children: [
            // overview title
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            //-- Overview cards Gridview --//
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: containerTitles.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomContainer(
                  containerTitles: containerTitles,
                  icons: containerIcons,
                  index: index,
                );
              },
            ),
            const SizedBox(height: 20),
            // Employee list title
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 10),
                const Text(
                  'Employees List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                // View all button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      // we will send the employees list from firebase
                      // to the employees page
                      arguments: UsersCubit.get(context).employees,
                      context,
                      AppRoutes.employees,
                    );
                  },
                  child: const Text(
                    AppStrings.viewAll,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            //------- Employee list view -------//
            // Show half of the employees list of the length is greater than 4
            BlocBuilder<UsersCubit, UsersState>(
              builder: (context, state) {
                final cubit = UsersCubit.get(context);
                List<UserModel> employees = cubit.employees;
                return Skeletonizer(
                  enabled: state is UsersLoading,
                  child: UsersList(
                    users: state is UsersLoading
                        ? dummyUsersObjects
                        : employees.length <= 4
                            ? employees
                            : employees.sublist(
                                0,
                                (employees.length * 0.5).round(),
                              ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////
