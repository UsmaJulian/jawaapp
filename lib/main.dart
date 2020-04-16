import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/add_page.dart';
import 'package:jawaaplicacion/src/pages/content_page.dart';
import 'package:jawaaplicacion/src/pages/home_page.dart';
import 'package:jawaaplicacion/src/pages/preferences_page.dart';
import 'package:jawaaplicacion/src/pages/profile_page.dart';
import 'package:jawaaplicacion/src/pages/selection_page.dart';
import 'package:jawaaplicacion/src/pages/sign_in_page.dart';
import 'package:jawaaplicacion/src/pages/splash_page.dart';
import 'package:jawaaplicacion/src/providers/firebase_auth_provider.dart';
import 'package:jawaaplicacion/src/providers/image_picker_provider.dart';
import 'package:jawaaplicacion/src/widgets/auth_widget_builder.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<ImagePickerService>(
          create: (_) => ImagePickerService(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (context, userSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jawa App',
            initialRoute: 'splash',
            routes: {
              'splash': (BuildContext context) => SplashPage(),
              'sign': (BuildContext context) => SignInPage(),
              'home': (BuildContext context) => HomePage(),
              'profile': (BuildContext context) =>
                  ProfilePage(uid: userSnapshot.data.uid),
              'preferences': (BuildContext context) => PreferencesPage(),
              'add': (BuildContext context) =>
                  AddPage(uid: userSnapshot.data.uid),
              'content': (BuildContext context) => ContentPage(),
              'selection': (BuildContext context) => SelectionPage(),
            },
            theme: ThemeData(primaryColor: Colors.orange),
          );
        },
      ),
    );
  }
}
