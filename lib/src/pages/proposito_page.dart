import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class PropositoPage extends StatefulWidget {
  @override
  _PropositoPageState createState() => _PropositoPageState();
}

class _PropositoPageState extends State<PropositoPage> {
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
          child: Text(
            'Identificación y registro de prácticas artísticas correspondientes a apropiaciones simbólicas duraderas en el espacio público de la Ciudad de Bogotá, con una posterior catalogación georreferenciada de dichas obras artísticas por medio de una aplicación móvil multiplataforma promovida por medio de un sistema de curaduría colaborativa (ciudadanos + expertos), abordado desde una perspectiva de investigación-creación.',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
