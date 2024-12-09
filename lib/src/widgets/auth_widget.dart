import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/home_page.dart';
import 'package:jawaaplicacion/src/pages/sign_in_page.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({required this.userSnapshot, super.key});
  final AsyncSnapshot userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? const HomePage() : const SignInPage();
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
