import 'package:flutter/material.dart';
import 'package:p_1/core/theme/app_theme.dart';
import 'package:p_1/entry_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

TargetPlatform? _platform;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.light.copyWith(
          platform: _platform ?? Theme.of(context).platform,
        ),
        home: const EntryScreen());
  }
}
