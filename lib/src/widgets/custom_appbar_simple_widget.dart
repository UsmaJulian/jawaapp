import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 60.0,
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
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: 30.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 2.5,
                )),
            Expanded(child: Container()),
            IconButton(
              icon: Icon(
                CupertinoIcons.gear_solid,
                size: 30,
                color: Colors.orange,
              ),
              onPressed: () => Navigator.pushNamed(context, 'preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
