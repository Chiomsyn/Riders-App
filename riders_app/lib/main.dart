import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/styles.dart';
import 'package:riders_app/data_handler/firebase/auth.dart';
import 'package:riders_app/data_handler/map/home_provider.dart';
import 'package:riders_app/data_handler/map/request_provider.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:riders_app/presentation/pages/auth_loading.dart';
import 'package:riders_app/presentation/pages/verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/global/app_var.dart';
import 'data_handler/dark_theme_provider.dart';
import 'data_handler/map/position_provider.dart';
import 'data_handler/firebase/user_provider.dart';
import 'data_handler/map/search_prediction.dart';
import 'presentation/pages/home.dart';
import 'presentation/pages/onboarding_screen.dart';

int? initScreen = 0;
String? userStatus = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  userStatus = preferences.getString('userStatus');
  await preferences.setInt('initScreen', 1);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AuthHandler.initialize(),
      ),
      ChangeNotifierProvider.value(value: DarkThemeProvider()),
      ChangeNotifierProvider.value(value: PositionProvider()),
      ChangeNotifierProvider.value(value: RequestProvider()),
      ChangeNotifierProvider.value(value: HomeProvider()),
      ChangeNotifierProvider.value(value: SearchPredictionProvider()),
      ChangeNotifierProvider.value(value: UserServiceProvider())
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
    Provider.of<PositionProvider>(context, listen: false)
        .locatePosition(context);
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

  Widget getPages(AuthHandler auth) {
    String userType = "";

    if (currentFirebaseUser != null) {
      userType = currentFirebaseUser!.displayName ?? '';
    }

    if ((initScreen ?? 0) < 1) {
      return const OnboardingScreen();
    } else if (userStatus == "user created") {
      return const VerificationPage();
    } else if (auth.status == Status.authenticated &&
        userType == "user verified") {
      return const AuthLoading();
    } else if ((initScreen ?? 0) < 2) {
      return const LogInPage();
    } else {
      return const HomePage();
    }
  }
}
