import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          child: CustomAppBarComp(),
          preferredSize: Size(double.infinity, 70),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Container(
                width: size.width * 0.7,
                height: 60,
                child: Center(
                  child: Text(
                    'Nosotros',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 14.0,
                          color: Colors.black38,
                          offset: Offset(0.0, 12.0),
                        ),
                      ],
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 35.0,
            ),
            RaisedButton(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: Container(
                width: size.width * 0.7,
                height: 60,
                child: Center(
                  child: Text(
                    'Ayuda',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 14.0,
                          color: Colors.black38,
                          offset: Offset(0.0, 12.0),
                        ),
                      ],
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
