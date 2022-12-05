import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/providers/firebase_auth_provider.dart';
import 'package:jawaaplicacion/src/providers/firebase_storage_provider.dart';
import 'package:jawaaplicacion/src/providers/firestore_provider.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthService>(context, listen: true);
    return StreamBuilder<UserAuth?>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final UserAuth? user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<UserAuth>.value(value: user),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
