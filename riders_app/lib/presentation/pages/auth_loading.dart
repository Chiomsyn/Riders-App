import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/presentation/pages/home.dart';
import 'package:riders_app/presentation/pages/profile_page.dart';

import '../../core/global/app_var.dart';
import '../../data_handler/firebase/auth.dart';

class AuthLoading extends StatefulWidget {
  const AuthLoading({super.key});

  @override
  State<AuthLoading> createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);
    return FutureBuilder(
        future: auth.getUser(currentFirebaseUser!.uid),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          final data = snapshot.data;
          // print(data!.status);
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.status == "created") {
              return ProfilePage();
            } else {
              return HomePage();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
