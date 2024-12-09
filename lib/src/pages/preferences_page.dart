import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/about_page.dart';
import 'package:jawaaplicacion/src/pages/contact_page.dart';
import 'package:jawaaplicacion/src/pages/legal_page.dart';
import 'package:jawaaplicacion/src/pages/proposito_page.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final actionItems = getListOfActionButtons(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBarComp(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 90),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: List.generate(actionItems.length, (index) {
            return Center(
              child: ButtonTheme(
                colorScheme: const ColorScheme.dark(),
                minWidth: 150,
                child: actionItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> getListOfActionButtons(BuildContext context) {
    final actionItems = <Widget>[];

    actionItems.addAll([
      // ButtonTheme(
      //   buttonColor: Color(0xffFFBA2E),
      //   minWidth: 160,
      //   height: 40,
      //   child: RaisedButton(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //     ),
      //     child: Text(
      //       "WIFI",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     onPressed: () {
      //       AppSettings.openWIFISettings();
      //     },
      //   ),
      // ),
      // ButtonTheme(
      //   buttonColor: Color(0xffFFBA2E),
      //   minWidth: 160,
      //   height: 40,
      //   child: RaisedButton(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //     ),
      //     child: Text(
      //       "Fecha",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     onPressed: () {
      //       AppSettings.openDateSettings();
      //     },
      //   ),
      // ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          child: const Text(
            'Nosotros',
            style: TextStyle(color: Colors.white),
          ),
        ),

        // RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PropositoPage()),
            );
          },
          child: const Text(
            'Propósito',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //  RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            );
          },
          child: const Text(
            'Contacto',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //  RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LegalPage()),
            );
          },
          child: const Text(
            'Política de datos',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //  RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            AppSettings.openAppSettings(type: AppSettingsType.location);
          },
          child: const Text(
            'Localización',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //  RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
      ButtonTheme(
        buttonColor: const Color(0xffFFBA2E),
        minWidth: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            AppSettings.openAppSettings(
              type: AppSettingsType.internalStorage,
            );
          },
          child: const Text(
            'Almacenamiento interno',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),

        //  RaisedButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20.0),
        //   ),
        //   child:

        // ),
      ),
    ]);

    return actionItems;
  }
}
