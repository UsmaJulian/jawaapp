import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jawaaplicacion/src/utils/field_selection.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget%20copy.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final fieldP = FieldSelection();
  String field = 'ubicacion';
  @override
  void initState() {
    field = fieldP.seleccion;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(field);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarCompCopy(),
          _gridcollections(context, field),
        ],
      ),
    );
  }

  SizedBox _gridcollections(BuildContext context, String field) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * .87,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ingresos')
            .orderBy(field)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const CupertinoActivityIndicator();
          } else {
            return Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: _SwiperCollection(
                      data: snapshot.data!.docs[index].data(),
                    ),
                    onTap: () {
                      final datos = snapshot.data!.docs[index].data();
                      Navigator.pushNamed(
                        context,
                        'content',
                        arguments: datos,
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class _SwiperCollection extends StatefulWidget {
  const _SwiperCollection({super.key, this.data});
  final data;

  @override
  __SwiperCollectionState createState() => __SwiperCollectionState();
}

class __SwiperCollectionState extends State<_SwiperCollection> {
  @override
  Widget build(BuildContext context) {
    final imagenes =
        List<String>.from(widget.data['imagenes'] as List<dynamic>);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.15,
            color: Colors.white,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.png'),
                  image: NetworkImage(
                    (imagenes[index].isNotEmpty)
                        ? imagenes[index]
                        : 'https://res.cloudinary.com/det3hixp6/image/upload/v1670263919/logo_jygjvf.png',
                  ),
                  fit: BoxFit.cover,
                );
              },
              itemCount: imagenes.length,
              pagination: const SwiperPagination(
                margin: EdgeInsets.only(
                  bottom: 12,
                ),
                builder: DotSwiperPaginationBuilder(
                  activeColor: Color(0xffFFBA2E),
                  size: 6,
                  activeSize: 6,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  '${widget.data['tecnica']}',
                  style: const TextStyle(
                    color: Color(0xffFFBA2E),
                  ),
                ),
              ),
              Container(
                child: Text('${widget.data['ubicacion']}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
