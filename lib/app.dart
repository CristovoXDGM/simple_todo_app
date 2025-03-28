import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/app_router.dart';
import 'package:simple_simple_todo/src/core/constants/app_colors.dart';
import 'package:simple_simple_todo/src/core/constants/app_text_styles.dart';
import 'package:simple_simple_todo/src/core/di/setup_dependecy_injection.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    SetupDependecyInjection().setup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: taskStyle,
          hintStyle: hintStyle,
          counterStyle: taskStyle,
          helperStyle: taskStyle,
          filled: true,
          fillColor: AppColors.primaryColor,
        ),
      ),
      routerConfig: router,
    );
  }
}
