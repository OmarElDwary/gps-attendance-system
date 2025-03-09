import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gps_attendance_system/core/cubits/change_language_cubit.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Theme.of(context).primaryColor,
                value: context
                    .watch<ChangeLanguageCubit>()
                    .state
                    .locale
                    .languageCode,
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text(
                      AppLocalizations.of(context)!.english,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<ChangeLanguageCubit>().changeLanguage(value);
                  }
                },
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
