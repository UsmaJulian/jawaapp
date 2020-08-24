import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/providers/firebase_auth_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);

      await auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  final PageController _controller = PageController();

  List<Widget> _list = [
    SliderBox(
        child: Column(
      children: [
        Image.asset(
          'assets/demo/Asset 2.png',
          height: 400,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
          child: Text(
            "Con Jawa podrás capturar imágenes de obras de arte público que llamen tu atención. Simplemente debes tomar una fotografía desde la app o importarla desde tu galería.",
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    )),
    SliderBox(
        child: Column(
      children: [
        Image.asset(
          'assets/demo/Asset 3.png',
          height: 400,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
          child: Text(
            "Asegúrate de tener encendido el gps de tu dispositivo para que podamos registrar la ubicación de la obra en la ciudad.",
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    )),
    SliderBox(
        child: Column(
      children: [
        Image.asset(
          'assets/demo/Asset 4.png',
          height: 400,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
          child: Text(
            "Para terminar, completa las casillas de información requeridas y ya está. Dentro de la app podrás navegar por cientos de registros de obras de arte público, hechos por muchas personas en diferentes zonas del país.",
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    )),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = _controller.page.round() + 1;

      if (nextPage == _list.length) {
        nextPage = 0;
      }

      _controller
          .animateToPage(nextPage,
              duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                child: PageView(
                  children: _list,
                  controller: _controller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  color: Colors.orange,
                  child: Container(
                      width: 200, child: Center(child: Text('Ingresar'))),
                  onPressed: () => _signInAnonymously(context),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliderBox extends StatelessWidget {
  final Widget child;
  const SliderBox({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10), child: child);
  }
}
