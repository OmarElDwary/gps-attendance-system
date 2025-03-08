import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/utils/custom_calendar_timeline.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/search_container.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/users_list.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  TextEditingController searchController = TextEditingController();
  List<String> allEmployees = [
    'John Doe',
    'Jane Doe',
    'Monia Mohamed',
    'Jane Doe',
    'John Doe',
    'Jane Doe',
    'Jane Doe',
  ];
  List<String> filteredEmployees = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    filteredEmployees = allEmployees;
  }

  void filterEmployees(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredEmployees = allEmployees;
      } else {
        filteredEmployees = allEmployees
            .where((employee) =>
                employee.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenPadding = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(title: const Text('Employees Records')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: screenPadding),
        child: Column(
          children: [
            CustomCalendarTimeline(
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),
            const SizedBox(height: 10),
            SearchContainer(
              controller: searchController,
              onSearch: filterEmployees,
            ),
            const SizedBox(height: 10),
            Expanded(child: UsersList(dummyEmployees: filteredEmployees)),
          ],
        ),
      ),
    );
  }
}
