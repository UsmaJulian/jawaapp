import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
            'La aplicación Jawa es producto del proyecto de investigación denominado “Diseño e implementación de una estrategia de curaduría colaborativa para el registro en línea de intervenciones artísticas en Bogotá D.C. a través de una aplicación para dispositivos móviles articulada a la plataforma MUNAD (Museo Universitario de Artes Digitales)” desarrollado en la Universidad Nacional Abierta y a Distancia, por el equipo docente del programa de Artes visuales. El proyecto plantea el registro y análisis de prácticas artísticas realizadas en espacios públicos o no convencionales de la ciudad de Bogotá, que hagan uso de la estrategia de apropiación simbólica duradera. Después de un proceso de sistematización de dicha información se pretende establecer categorías y posibles formas de clasificación para identificar procesos de creación llevados a cabo en la ciudad, así como su orientación temática, técnica, política, estética, entre otros.',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
