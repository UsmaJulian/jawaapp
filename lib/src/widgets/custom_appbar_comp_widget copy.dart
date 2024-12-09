import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/utils/field_selection.dart';

class CustomAppBarCompCopy extends StatefulWidget {
  const CustomAppBarCompCopy({super.key});

  @override
  _CustomAppBarCompCopyState createState() => _CustomAppBarCompCopyState();
}

class _CustomAppBarCompCopyState extends State<CustomAppBarCompCopy> {
  Color? _color1;
  Color? _color2;
  final fieldP = FieldSelection();
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
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 40, // has the effect of softening the shadow
              spreadRadius: 1, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                3, // vertical, move down 10
              ),
            ),
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                CupertinoIcons.left_chevron,
                size: 30,
              ),
              onPressed: () => Navigator.pushNamed(context, 'home'),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2.5,
              ),
            ),
            IconButton(
              icon: const Icon(
                CupertinoIcons.search,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Ordenar Colección por: '),
                    content: SizedBox(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Text(
                              'Técnica',
                              style: TextStyle(color: _color1),
                            ),
                            onTap: () {
                              setState(() {
                                _color1 = const Color(0xffFFBA2E);
                                _color2 = Colors.grey;
                                fieldP.seleccion = 'tecnica';
                              });
                              Navigator.pushNamed(context, 'collection');
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            child: Text(
                              'Ubicación',
                              style: TextStyle(color: _color2),
                            ),
                            onTap: () {
                              setState(() {
                                fieldP.seleccion = 'ubicacion';
                                _color1 = Colors.grey;
                                _color2 = const Color(0xffFFBA2E);
                              });
                              Navigator.pushNamed(context, 'collection');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
