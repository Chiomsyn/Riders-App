import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/styles.dart';
import 'package:riders_app/data_handler/auth.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:riders_app/presentation/pages/verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_handler/dark_theme_provider.dart';
import 'presentation/pages/onboarding_screen.dart';
import 'presentation/pages/profile_page.dart';

int? initScreen = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AuthHandler.initialize(),
      ),
      ChangeNotifierProvider.value(value: DarkThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<DarkThemeProvider>(context, listen: false)
        .darkThemePreference
        .getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Styles.lightThemeData(context),
        darkTheme: Styles.darkThemeData(context),
        title: 'Flutter Demo',
        home: getPages(auth));
  }

  Widget? getPages(AuthHandler auth) {
    if (auth.status == Status.uninitialized && initScreen! < 1) {
      return const OnboardingScreen();
    } else if (initScreen! < 2 &&
        (auth.status == Status.unauthenticated ||
            auth.status == Status.authenticating)) {
      return const LogInPage();
    } else if (auth.status == Status.authenticated && initScreen! < 3) {
      return const VerificationPage();
    } else if (auth.status == Status.authenticated && initScreen! > 4) {}
  }
}
