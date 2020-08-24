import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarComp extends StatelessWidget {
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
                onPressed: () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2.5,
              ),
            ),
            SizedBox(
              width: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
