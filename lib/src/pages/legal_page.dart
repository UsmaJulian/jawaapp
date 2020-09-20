import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class LegalPage extends StatefulWidget {
  @override
  _LegalPageState createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBarComp(),
        preferredSize: Size(double.infinity, 70),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  '¿Qué tipo de información recopila esta aplicación?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Con la intención de crear la base de datos de obras, la aplicación Jawa compila principalmente registros fotográficos de obras en espacio público de la ciudad de Bogotá con la finalidad de visibilizar y circular la producción artística que tiene lugar en espacios de la ciudad. Como punto de partida la aplicación recolecta los datos de ubicación de las fotografías y la información que los usuarios aportan por medio de los formularios de entrega.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'La aplicación no hace uso de datos personales y los medios que requiere del dispositivo móvil del usuario son los estrictamente necesarios para llevar a cabo el proceso de registro de las obras. ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Imágenes ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Las imágenes compartidas en la aplicación son obtenidas por medio del acceso a la cámara y al almacenamiento de galería del dispositivo móvil. Este uso es posible únicamente al ser autorizado por el usuario. ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Las imágenes compartidas en la aplicación corresponden a registros hechos por sus usuarios en diferentes locaciones. Se trata de fotografías de espacios de la ciudad. Los usuarios conceden derechos sobre las imágenes al hacer uso de la aplicación. La aplicación Jawa compila estas imágenes con la intención de crear una base de obras, no tienen ninguna intención de fines de lucro, sus propósitos son meramente de difusión y educativos. ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'En las imágenes en que es posible se comparte el nombre del autor o autora. En otros casos las obras aparecen como autor desconocido o anónimo. Esto por desconocer su autoría o por requisito de los autores de mantener la obra como anónima. Si un usuario desea ser reconocido como el autor de alguna de las obras registradas puede comunicarse con los creadores de la aplicación para llevar a cabo este proceso. ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Información de dispositivos',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Para poder entregar la información de ubicación de las imágenes, la aplicación compila información de geolocalización entregada de manera voluntaria por los usuarios. De igual manera, por medio del formulario, los usuarios comparten información escrita acerca de las imágenes capturadas y su posible identificación temática y técnica. Esta información es revisada por los administradores de la aplicación y publicada posteriormente.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  '¿Qué debo hacer para participar en este proyecto?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Existen diferentes formas de participación en este proyecto. (1)En caso de que un usuario o artista desea que su obra aparezca en el registro de la app, puede comunicarse con los administradores de la aplicación o agregar su registro por medio de la aplicación. (2) En caso de tener una propuesta de curaduría o registro, tenga en cuenta que los investigadores creadores de la aplicación están abiertos a propuestas, para esto debe comunicarse con ellos.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
