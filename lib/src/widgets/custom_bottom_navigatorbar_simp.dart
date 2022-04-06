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
      height: 77,
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
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    selectedLabelStyle: TextStyle(
                        color: Color(0xffFFBA2E),
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    items: [
                      BottomNavigationBarItem(
                        icon: IconButton(
                          icon: Icon(
                            CupertinoIcons.profile_circled,
                            size: 30,
                            color: Color(0xffFFBA2E),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, 'profile'),
                          // Navigator.pushNamed(context, 'selection'),
                        ),
                        label: 'Perfil',
                      ),
                      BottomNavigationBarItem(
                        icon: IconButton(
                          icon: Icon(
                            CupertinoIcons.book_solid,
                            size: 30,
                            color: Color(0xffFFBA2E),
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            'collection',
                          ),
                        ),
                        label: 'Biblioteca',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
