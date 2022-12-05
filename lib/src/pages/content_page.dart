import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(child: _buildImage(data)),
              CustomAppBarComp(),
            ],
          ),
        ));
  }

  Widget _buildImage(data) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 70.0,
        ),
        _SwipperImages(data: data),
        _buildCards(data),
        // _buildHorListViewPhotos(data),
        const SizedBox(
          height: 35.0,
        ),
      ],
    );
  }

  Widget _buildCards(data) {
    Timestamp t = data['fecha de captura'];
    // ignore: unused_local_variable
    DateTime d = t.toDate();
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  'Creador/Autor: ',
                  style: TextStyle(color: Color(0xffFFBA2E)),
                ),
                subtitle: Text('${data['creador']}'),
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
                title: const Text(
                  'Técnica artística: ',
                  style: TextStyle(color: Color(0xffFFBA2E)),
                ),
                subtitle: Text('${data['tecnica']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  'Ubicación: ',
                  style: TextStyle(color: Color(0xffFFBA2E)),
                ),
                subtitle: Text('${data['ubicacion']}'),
              )),
          Card(
              elevation: 2,
              child: ListTile(
                title: const Text(
                  'Enlace de contacto del creador: ',
                  style: TextStyle(color: Color(0xffFFBA2E)),
                ),
                subtitle: Text('${data['enlace']}'),
              )),
          // Card(
          //     elevation: 2,
          //     child: ListTile(
          //       title: Text(
          //         'Fecha de captura de la fotografía: ',
          //         style: TextStyle(color: Color(0xffFFBA2E)),
          //       ),
          //       subtitle: Text('${d.toString()}'),
          //     )),
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
    List<String> imagenes = data['imagenes'].cast<String>();
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      color: Colors.white,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return FadeInImage(
            placeholder: const AssetImage('assets/images/no-image.png'),
            image: NetworkImage((imagenes[index].isNotEmpty)
                ? imagenes[index]
                : 'https://res.cloudinary.com/det3hixp6/image/upload/v1670263919/logo_jygjvf.png'),
            fit: BoxFit.cover,
          );
        },
        itemCount: imagenes.length,
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(
              bottom: 12.0,
            ),
            builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xffFFBA2E), size: 6.0, activeSize: 6)),
      ),
    );
  }
}
