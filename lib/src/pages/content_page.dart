import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(child: _buildImage(data)),
        CustomAppBarComp(),
      ],
    ));
  }

  Widget _buildImage(data) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 130.0,
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0),
          height: size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.png'),
              image: NetworkImage('${data['imagen destacada']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildCards(data),
        _buildHorListViewPhotos(data),
        SizedBox(
          height: 35.0,
        ),
      ],
    );
  }

  Widget _buildCards(data) {
    Timestamp t = data['fecha de captura'];
    DateTime d = t.toDate();
    return Container(
      margin: EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Creador/Autor: '),
                subtitle: Text('${data['creador/autor']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Enlace de contacto del creador: '),
                subtitle: Text('${data['enlace']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Fecha de captura de la fotografía: '),
                subtitle: Text('${d.toString()}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Temática: '),
                subtitle: Text('${data['tematica']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Técnica artística: '),
                subtitle: Text('${data['tecnica']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text('Ubicación: '),
                subtitle: Text('${data['ubicacion']}'),
              )),
        ],
      ),
    );
  }

  _buildHorListViewPhotos(data) {
    return Container(
      width: double.infinity,
      height: 200,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: data['imagenes']
              .map<Widget>((value) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/no-image.png'),
                        image: NetworkImage(value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
