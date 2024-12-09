import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/sign_in_page.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PropositoPage extends StatefulWidget {
  const PropositoPage({super.key});

  @override
  _PropositoPageState createState() => _PropositoPageState();
}

class _PropositoPageState extends State<PropositoPage> {
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Con Jawa podrás capturar imágenes de obras de arte público que llamen tu atención. Simplemente debes tomar una fotografía desde la app o importarla desde tu galería.',
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
    SliderBox(
      child: Column(
        children: [
          Image.asset(
            'assets/demo/Asset 3.png',
            height: 400,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Asegúrate de tener encendido el gps de tu dispositivo para que podamos registrar la ubicación de la obra en la ciudad.',
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
    SliderBox(
      child: Column(
        children: [
          Image.asset(
            'assets/demo/Asset 4.png',
            height: 400,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Para terminar, completa las casillas de información requeridas y ya está. Dentro de la app podrás navegar por cientos de registros de obras de arte público, hechos por muchas personas en diferentes zonas del país.',
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    // _animateSlider();
  }

  // void _animateSlider() {
  //   Future.delayed(const Duration(seconds: 2)).then((_) {
  //     var nextPage = _controller.page!.round() + 1;

  //     if (nextPage == _list.length) {
  //       nextPage = 0;
  //     }

  //     _controller
  //         .animateToPage(
  //           nextPage,
  //           duration: const Duration(seconds: 1),
  //           curve: Curves.linear,
  //         )
  //         .then((_) => _animateSlider());
  //   });
  // }

  @override
  void dispose() {
    print('dispose');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: CustomAppBarComp(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.9,
                child: PageView(
                  controller: _controller,
                  children: _list,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: const Center(
                  child: Text(
                    'Identificación y registro de prácticas artísticas correspondientes a apropiaciones simbólicas duraderas en el espacio público de la Ciudad de Bogotá, con una posterior catalogación georreferenciada de dichas obras artísticas por medio de una aplicación móvil multiplataforma promovida por medio de un sistema de curaduría colaborativa (ciudadanos + expertos), abordado desde una perspectiva de investigación-creación.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
}
