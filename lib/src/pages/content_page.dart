import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
        extendBodyBehindAppBar: false,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(child: _buildImage(data)),
            CustomAppBarComp(),
          ],
        ));
  }

  Widget _buildImage(data) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        _SwipperImages(data: data),
        _buildCards(data),
        // _buildHorListViewPhotos(data),
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
                title: Text(
                  'Creador/Autor: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text('${data['creador/autor']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Enlace de contacto del creador: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text('${data['enlace']}'),
              )),
          // Card(
          //     elevation: 2,
          //     child: ListTile(
          //       title: Text('Temática: '),
          //       subtitle: Text('${data['tematica']}'),
          //     )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Técnica artística: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text('${data['tecnica']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Ubicación: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text('${data['ubicacion']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  'Fecha de captura de la fotografía: ',
                  style: TextStyle(color: Colors.orange),
                ),
                subtitle: Text('${d.toString()}'),
              )),
        ],
      ),
    );
  }

  // _buildHorListViewPhotos(data) {
  //   return Container(
  //     width: double.infinity,
  //     height: 200,
  //     child: ListView(
  //         scrollDirection: Axis.horizontal,
  //         children: data['imagenes']
  //             .map<Widget>((value) => Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 10),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: FadeInImage(
  //                       placeholder: AssetImage('assets/images/no-image.png'),
  //                       image: NetworkImage(value),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ))
  //             .toList()),
  //   );
  // }
}

class _SwipperImages extends StatelessWidget {
  final data;

  const _SwipperImages({this.data});
  @override
  Widget build(BuildContext context) {
    List<String> imagenes = this.data['imagenes'].cast<String>();
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return FadeInImage(
            placeholder: AssetImage('assets/images/no-image.png'),
            image: NetworkImage('${imagenes[index]}'),
            fit: BoxFit.fill,
          );
        },
        itemCount: imagenes.length,
        pagination: new SwiperPagination(
            margin: EdgeInsets.only(
              bottom: 12.0,
            ),
            builder: DotSwiperPaginationBuilder(
                activeColor: Colors.orange, size: 6.0, activeSize: 6)),
      ),
    );
  }
}
