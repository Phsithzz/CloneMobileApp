import 'package:clone_mobile_app/bloc/calenda_bloc.dart';
import 'package:clone_mobile_app/bloc/calenda_event.dart';
import 'package:clone_mobile_app/screens/invite_page.dart';
import 'package:clone_mobile_app/theme/app_theme.dart';
import 'package:clone_mobile_app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

@override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => CalendarBloc()..add(LoadMonthEvent(DateTime(2026, 1)))), 
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Empeo App Clone',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            // เปลี่ยนหน้าแรกให้เริ่มที่ Invitation Page แทน Calendar
            home: const InvitePage(), 
          );
        },
      ),
    );
  }
}
