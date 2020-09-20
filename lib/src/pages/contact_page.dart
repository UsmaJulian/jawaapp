import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBarComp(),
        preferredSize: Size(double.infinity, 70),
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Investigador principal: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Ricardo Hernández Forero ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Coinvestigadores: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Tatiana Martínez Santis ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Silvia Lozano Prat ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Raúl Alejandro Martínez ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Página oficial de la aplicación: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              ButtonTheme(
                buttonColor: Color(0xffFFBA2E),
                minWidth: 160,
                height: 40,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: _launchURL,
                  child: Text(
                    'http://munad.unad.edu.co/jawa-app',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'http://munad.unad.edu.co/jawa-app';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
