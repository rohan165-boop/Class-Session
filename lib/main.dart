import 'package:flutter/material.dart';
import 'package:p_1/core/theme/app_theme.dart';
import 'package:p_1/entry_screen.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

TargetPlatform? _platform;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'Public Key',
        enabledDebugging: false,
        builder: (context, navigatorKey) {
          return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppTheme.light.copyWith(
                platform: _platform ?? Theme.of(context).platform,
              ),
              home: const EntryScreen());
        });
  }
}
