import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/sign_in_page.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PropositoPage extends StatefulWidget {
  @override
  _PropositoPageState createState() => _PropositoPageState();
}

class _PropositoPageState extends State<PropositoPage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
      appBar: PreferredSize(
        child: CustomAppBarComp(),
        preferredSize: Size(double.infinity, 70),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.70,
              child: PageView(
                children: _list,
                controller: _controller,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35.0, right: 35.0),
              child: Center(
                child: Text(
                  'Identificación y registro de prácticas artísticas correspondientes a apropiaciones simbólicas duraderas en el espacio público de la Ciudad de Bogotá, con una posterior catalogación georreferenciada de dichas obras artísticas por medio de una aplicación móvil multiplataforma promovida por medio de un sistema de curaduría colaborativa (ciudadanos + expertos), abordado desde una perspectiva de investigación-creación.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
