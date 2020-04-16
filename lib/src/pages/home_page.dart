import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/pages/maps_page.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_simple_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          MapsPage(),
          
          CustomAppBarSimple(),
        ],
      ),
    );
  }
}
