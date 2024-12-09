import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBarComp(),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Investigador principal: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Ricardo Hernández Forero ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Coinvestigadores: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Tatiana Martínez Santis ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Silvia Lozano Prat ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Raúl Alejandro Martínez ',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              const Text(
                'Página oficial de la aplicación: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffFFBA2E),
                ),
                textAlign: TextAlign.justify,
              ),
              ButtonTheme(
                buttonColor: const Color(0xffFFBA2E),
                minWidth: 160,
                height: 40,
                child: ElevatedButton(
                  onPressed: _launchURL,
                  child: const Text(
                    'http://munad.unad.edu.co/jawa-app',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                ),

                //  RaisedButton(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20.0),
                //   ),

                //   child:
                // ),
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
