import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gps_attendance_system/blocs/language/change_language_cubit.dart';
import 'package:gps_attendance_system/blocs/language/change_language_state.dart';
import 'package:gps_attendance_system/blocs/theme/theme_bloc.dart';
import 'package:gps_attendance_system/blocs/theme/theme_state.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/employess_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/geofence_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_approvals_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/settings_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/total_leaves_page.dart';
import 'package:gps_attendance_system/presentation/screens/leaves/leaves_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeLanguageCubit()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                locale: languageState.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: AppRoutes.adminHome,
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case AppRoutes.adminHome:
                      return MaterialPageRoute(
                          builder: (context) => AdminHome());
                    case AppRoutes.employees:
                      return MaterialPageRoute(
                          builder: (context) => const EmployeesPage());
                    case AppRoutes.geofence:
                      return MaterialPageRoute(
                          builder: (context) => const GeofencePage());
                    case AppRoutes.settings:
                      return MaterialPageRoute(
                          builder: (context) => const SettingsPage());
                    case AppRoutes.totalLeaves:
                      return MaterialPageRoute(
                          builder: (context) => const TotalLeavesPage());
                    case AppRoutes.pendingApprovals:
                      return MaterialPageRoute(
                          builder: (context) => const PendingApprovalsPage());
                    case AppRoutes.leaves:
                      return MaterialPageRoute(
                          builder: (context) => const LeavesPage());
                    default:
                      return MaterialPageRoute(
                          builder: (context) => AdminHome());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
