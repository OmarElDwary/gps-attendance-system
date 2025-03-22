import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';

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
                CustomListTile(
                  title: 'Reset Password',
                  leadingIcon: Icons.lock,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.resetPassword,
                    );
                  },
                ),
                CustomListTile(
                  title: 'View Attendance History',
                  leadingIcon: Icons.description,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      arguments: userData,
                      AppRoutes.userDetailsRoute,
                    );
                  },
                ),
                CustomListTile(
                  title: 'Settings',
                  leadingIcon: Icons.settings,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
                CustomListTile(
                  title: 'Log out',
                  leadingIcon: Icons.logout,
                  onTap: () {
                    AuthCubit.get(context).logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (_) => false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
///////////////////////////////

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.leadingIcon,
    super.key,
    this.onTap,
  });

  final String title;
  final IconData leadingIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.grey),
      title: Text(title),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
