import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarSimple extends StatelessWidget {
  const CustomAppBarSimple({super.key});

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
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            const SizedBox(
              width: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 30),
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2.5,
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              icon: const Icon(
                CupertinoIcons.gear_solid,
                size: 30,
                color: Color(0xffFFBA2E),
              ),
              onPressed: () => Navigator.pushNamed(context, 'preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
