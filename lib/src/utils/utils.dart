import 'package:flutter/material.dart';

void showAlert(BuildContext context, String mensaje) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('información incorrecta'),
          content: Text(mensaje),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
            // FlatButton(
            //     child:
            //     ),
          ],
        );
      });
}

bool urlIsEmpty(String? url) {
  if (url == null) {
    print('vacio');
    return false;
  }
  return true;
}
