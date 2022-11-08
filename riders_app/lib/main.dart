import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/data_handler/auth.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:riders_app/presentation/pages/auth/sign_up.dart';

import 'presentation/pages/onboarding_screen.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/verification_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: AuthHandler())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LogInPage());
  }
}
