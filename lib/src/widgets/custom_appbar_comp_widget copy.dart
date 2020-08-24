import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/utils/field_selection.dart';

class CustomAppBarCompCopy extends StatefulWidget {
  @override
  _CustomAppBarCompCopyState createState() => _CustomAppBarCompCopyState();
}

class _CustomAppBarCompCopyState extends State<CustomAppBarCompCopy> {
  // ignore: unused_field
  Color _color;
  final fieldP = new FieldSelection();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 40.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  size: 30.0,
                ),
                onPressed: () => Navigator.pushNamed(context, 'home')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2.5,
              ),
            ),
            IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                  size: 30.0,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Ordenar Colección por: '),
                      content: Container(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Text(
                                'Técnica',
                                style: TextStyle(color: Colors.orange),
                              ),
                              onTap: () {
                                setState(() {
                                  fieldP.seleccion = 'tecnica';
                                });
                                Navigator.pushNamed(context, 'collection');
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            InkWell(
                              child: Text(
                                'Ubicación',
                                style: TextStyle(color: Colors.orange),
                              ),
                              onTap: () {
                                setState(() {
                                  fieldP.seleccion = 'ubicacion';
                                });
                                Navigator.pushNamed(context, 'collection');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
