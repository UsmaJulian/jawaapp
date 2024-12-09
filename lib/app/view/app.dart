import 'package:flutter/material.dart';

import 'package:jawaaplicacion/src/pages/add_page.dart';
import 'package:jawaaplicacion/src/pages/collection_page.dart';
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

class App extends StatelessWidget {
  const App({super.key});

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
            theme: ThemeData(
              primaryColor: const Color(0xffFFBA2E),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xffFFBA2E),
                onPrimary: const Color(0xffFFBA2E),
                secondary: const Color(0xffFFBA2E),
                onSecondary: const Color(0xffFFBA2E),
                surface: const Color(0xffFFBA2E),
                onSurface: const Color(0xffFFBA2E),
                error: const Color(0xffFFBA2E),
                onError: const Color(0xffFFBA2E),
                brightness: Brightness.light,
              ),
              iconTheme: const IconThemeData(color: Color(0xffFFBA2E)),
              appBarTheme: AppBarTheme(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              useMaterial3: false,
            ),
            title: 'Jawa App',
            initialRoute: 'splash',
            routes: {
              'splash': (BuildContext context) => const SplashPage(),
              'sign': (BuildContext context) => const SignInPage(),
              'home': (BuildContext context) => const HomePage(),
              'collection': (BuildContext context) => const CollectionPage(),
              'profile': (BuildContext context) =>
                  ProfilePage(uid: userSnapshot.data!.uid),
              'preferences': (BuildContext context) => const PreferencesPage(),
              'add': (BuildContext context) =>
                  AddPage(uid: userSnapshot.data!.uid),
              'content': (BuildContext context) => const ContentPage(),
              'selection': (BuildContext context) => const SelectionPage(),
            },
          );
        },
      ),
    );
  }
}
