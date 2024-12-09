import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:jawaaplicacion/src/utils/field_selection.dart';
import 'package:jawaaplicacion/src/utils/soporte_sel.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

bool USE_FIRESTORE_EMULATOR = false;
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA7AZDFN-FeuS1pXEp7cwRWan5BzlC9Cfo',
      appId: '1:550631012564:web:75651498a30aa025206341',
      messagingSenderId: '550631012564',
      projectId: 'jawa-bb4fd',
      storageBucket: 'jawa-bb4fd.appspot.com',
    ),
  );
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = const Settings(
      host: 'localhost:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }
  final prefField = FieldSelection();
  final sopSel = SoporteSel();
  await sopSel.initSopSel();
  await prefField.initFieldPref();

  runApp(await builder());
}
