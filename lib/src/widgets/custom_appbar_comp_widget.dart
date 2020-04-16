import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarComp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
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
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              fit: BoxFit.cover,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () => Navigator.pop(context)),
            Image(image: AssetImage('assets/images/logo.png')),
            SizedBox(
              width: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
