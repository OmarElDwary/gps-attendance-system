import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/utils/custom_calendar_timeline.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/search_container.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/users_list.dart';

class ManagersPage extends StatefulWidget {
  const ManagersPage({super.key});

  @override
  State<ManagersPage> createState() => _ManagersPageState();
}

class _ManagersPageState extends State<ManagersPage> {
  TextEditingController searchController = TextEditingController();

  List<String> allMangers = [
    'John Doe',
    'Jane Doe',
    'Monia Mohamed',
    'Jane Doe',
    'John Doe',
    'Jane Doe',
    'Jane Doe',
  ];
  List<String> filteredMangers = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    filteredMangers = allMangers;
  }

  void filterEmployees(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMangers = allMangers;
      } else {
        filteredMangers = allMangers
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
      appBar: AppBar(title: const Text('Mangers Records')),
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
            Expanded(child: UsersList(dummyEmployees: filteredMangers)),
          ],
        ),
      ),
    );
  }
}
