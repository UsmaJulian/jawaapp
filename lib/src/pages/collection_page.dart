import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jawaaplicacion/src/utils/field_selection.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget%20copy.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final fieldP = new FieldSelection();
  String field = "ubicacion";
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
        children: [CustomAppBarCompCopy(), _gridcollections(context, field)],
      ),
    );
  }

  _gridcollections(BuildContext context, String field) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * .87,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('ingresos')
                .orderBy(field.toString())
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return CupertinoActivityIndicator();
              } else {
                return Container(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data.docs.length,
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: _SwiperCollection(
                          data: snapshot.data.docs[index].data()),
                      onTap: () {
                        final datos = snapshot.data.docs[index].data();
                        Navigator.pushNamed(context, 'content',
                            arguments: datos);
                      },
                    );
                  },
                ));
              }
            }));
  }
}

class _SwiperCollection extends StatefulWidget {
  final data;
  const _SwiperCollection({Key key, this.data}) : super(key: key);

  @override
  __SwiperCollectionState createState() => __SwiperCollectionState();
}

class __SwiperCollectionState extends State<_SwiperCollection> {
  @override
  Widget build(BuildContext context) {
    List<String> imagenes = this.widget.data['imagenes'].cast<String>();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.15,
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
                      activeColor: Color(0xffFFBA2E),
                      size: 6.0,
                      activeSize: 6)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  '${widget.data['tecnica']}',
                  style: TextStyle(
                    color: Color(0xffFFBA2E),
                  ),
                ),
              ),
              Container(
                child: Text('${widget.data['ubicacion']}'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
