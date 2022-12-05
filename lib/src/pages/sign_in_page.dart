import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/providers/firebase_auth_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with AfterLayoutMixin<SignInPage> {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);

      await auth.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  final PageController _controller = PageController();

  final List<Widget> _list = [
    SliderBox(
        child: Column(
      children: [
        Image.asset(
          'assets/demo/Asset 2.png',
          height: 400,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
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
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (_controller.hasClients) {
        int nextPage = _controller.page!.round() + 1;

        if (nextPage == _list.length) {
          nextPage = 0;
        }

        _controller
            .animateToPage(nextPage,
                duration: const Duration(seconds: 1), curve: Curves.linear)
            .then((_) => _animateSlider());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.88,
                  child: PageView(
                    children: _list,
                    controller: _controller,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: const Color(0xffFFBA2E),
                        ),
                        onPressed: () => _signInAnonymously(context),
                        child: const Center(child: Text('Ingresar')))

                    //  RaisedButton(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: new BorderRadius.circular(20.0),
                    //   ),
                    //   color: ,
                    //   child: Container(
                    //       width: 200, child:),
                    //   onPressed: () => _signInAnonymously(context),
                    // ),
                    ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliderBox extends StatelessWidget {
  final Widget? child;
  const SliderBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(1), child: child);
  }
}
