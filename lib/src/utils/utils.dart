import 'package:flutter/material.dart';

void showAlert(BuildContext context, String mensaje) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('información incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop()),
          ],
        );
      });
}

bool urlIsEmpty(String url) {
  if(url==null){
  	print('vacio');
  	return false;
  }
  
}
