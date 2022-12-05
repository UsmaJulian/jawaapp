import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/about_page.dart';
import 'package:jawaaplicacion/src/pages/contact_page.dart';
import 'package:jawaaplicacion/src/pages/legal_page.dart';
import 'package:jawaaplicacion/src/pages/proposito_page.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var actionItems = getListOfActionButtons(context);

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBarComp(),
        preferredSize: Size(double.infinity, 70),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 90.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: List.generate(actionItems.length, (index) {
            return Center(
                child: ButtonTheme(
              colorScheme: ColorScheme.dark(),
              minWidth: 150.0,
              child: actionItems[index],
            ));
          }),
        ),
      ),
    );
  }

  List<Widget> getListOfActionButtons(BuildContext context) {
    var actionItems = <Widget>[];

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
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
            child: Text(
              "Nosotros",
              style: TextStyle(color: Colors.white),
            ),
          )

          // RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child:

          // ),
          ),
      ButtonTheme(
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PropositoPage()));
            },
            child: Text(
              "Propósito",
              style: TextStyle(color: Colors.white),
            ),
          )

          //  RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child:

          // ),
          ),
      ButtonTheme(
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactPage()));
            },
            child: Text(
              "Contacto",
              style: TextStyle(color: Colors.white),
            ),
          )

          //  RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child:

          // ),
          ),
      ButtonTheme(
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LegalPage()));
            },
            child: Text(
              "Política de datos",
              style: TextStyle(color: Colors.white),
            ),
          )

          //  RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child:

          // ),
          ),
      ButtonTheme(
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              AppSettings.openLocationSettings();
            },
            child: Text(
              "Localización",
              style: TextStyle(color: Colors.white),
            ),
          )

          //  RaisedButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   child:

          // ),
          ),
      ButtonTheme(
          buttonColor: Color(0xffFFBA2E),
          minWidth: 160,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              AppSettings.openInternalStorageSettings();
            },
            child: Text(
              "Almacenamiento interno",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )

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
