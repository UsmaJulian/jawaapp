import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/auth_widget.dart';
import 'package:jawaaplicacion/src/widgets/auth_widget_builder.dart';

import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  @override
  void initState() {
    _timer = Timer(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthWidgetBuilder(
            builder: (context, userSnapshot) =>
                AuthWidget(userSnapshot: userSnapshot),
          ),
        ),
      ),
    );
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            // backGround(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logoJawa(),
                spinLoading(),
                textoEsperar(),
                SizedBox(
                  width: double.infinity,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget logoJawa() {
    return Image(
      image: AssetImage('assets/images/logo.png'),
      width: 90,
      height: 90,
    );
  }

  Widget textoEsperar() {
    return Container(
        padding: EdgeInsets.only(top: 40.0), child: Text('Por favor espere'));
  }

  spinLoading() {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Loading(
        indicator: BallSpinFadeLoaderIndicator(),
        size: 30,
        color: Colors.black,
      ),
    );
  }

  backGround() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/back.png'), fit: BoxFit.cover)),
    );
  }
}
