import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/home_page.dart';
import 'package:jawaaplicacion/src/pages/sign_in_page.dart';
import 'package:jawaaplicacion/src/providers/firebase_auth_provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key, required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPage();
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
