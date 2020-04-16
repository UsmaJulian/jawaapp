import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigatorBarComp extends StatefulWidget {
  @override
  _CustomBottomNavigatorBarCompState createState() =>
      _CustomBottomNavigatorBarCompState();
}

class _CustomBottomNavigatorBarCompState
    extends State<CustomBottomNavigatorBarComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 7.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                    size: 45,
                    color: Colors.orange,
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'profile'),
                  // Navigator.pushNamed(context, 'selection'),
                ),
                title: Text(
                  'Perfil',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                )),
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(
                    CupertinoIcons.gear,
                    size: 45,
                    color: Colors.orange,
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'preferences'),
                ),
                title: Text(
                  'Preferencias',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
