import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/user_details_page.dart';
import 'package:gps_attendance_system/presentation/screens/settings/settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    user = _auth.currentUser;

    if (user != null) {
      userData = await UserService.getUserData(user!.uid);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${userData?.name}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${userData?.position}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              '${userData?.email}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const Divider(),
            ListView(
              shrinkWrap: true,
              children: [
                const ListTile(
                  leading: Icon(Icons.person, color: Colors.grey),
                  title: Text('My Profile'),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                ),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.grey),
                  title: const Text('Reset Password'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SettingsPage();
                        },
                      ),
                    );
                  },
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.grey),
                  title: const Text('View Attendance Record'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserDetailsPage(
                            userModel: userData!,
                          );
                        },
                      ),
                    );
                  },
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SettingsPage();
                        },
                      ),
                    );
                  },
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
