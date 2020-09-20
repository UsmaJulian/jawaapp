import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jawaaplicacion/src/utils/soporte_sel.dart';
import 'package:jawaaplicacion/src/utils/utils.dart' as utils;
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';

class AddPage extends StatefulWidget {
  AddPage({this.uid});

  final uid;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textCreadorEditingController = TextEditingController();
  TextEditingController _textEnlaceEditingController = TextEditingController();
  // ignore: unused_field
  TextEditingController _textSoporteEditingController = TextEditingController();
  // ignore: unused_field
  TextEditingController _textTematicaEditingController =
      TextEditingController();
  // ignore: unused_field
  TextEditingController _textTecnicaEditingController = TextEditingController();
  TextEditingController _textTituloEditingController = TextEditingController();
  TextEditingController _textUbicacionEditingController =
      TextEditingController();
  File photoP, photo1, photo2, photo3;
  String urlFoto;
  String urlFoto1;
  String urlFoto2;

  String creador;
  String enlace;
  String imagen;
  List<String> imagenes;
  GeoPoint localizacion;
  String soporte;
  String tecnica;
  String tematica;
  String titulo;
  String ubicacion;
  final sopSel = new SoporteSel();
  String valor = '';
  bool _validate() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    sopSel.soporte;
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    LatLng args = ModalRoute.of(context).settings.arguments;

    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint point =
        geo.point(latitude: args.latitude, longitude: args.longitude);
    print(widget.uid);
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBarComp(),
        preferredSize: Size(double.infinity, 70),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40.0,
              width: double.infinity,
            ),
            _buildPhotoHeader(context, photoP),
            SizedBox(
              height: 16.0,
            ),
            _buildDataForm(
              context,
            ),
            _buildPhotosH(context, photo1, photo2, photo3),
            _buildbuttons(
              context,
              point,
              urlFoto,
              urlFoto1,
              urlFoto2,
            ),
            SizedBox(
              height: 80.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoHeader(BuildContext context, File photoP) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 15.0, // has the effect of softening the shadow
              spreadRadius: 10.0, // has the effect of extending the shadow
              offset: Offset(
                6.0, // horizontal, move right
                6.0, // vertical, move down
              ),
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: _mostrarImagenP()),
      ),
      onTap: () => showAlertDialogP(context, photoP),
    );
  }

  Widget _mostrarImagenP() {
    if (photoP != null) {
      return Image.file(
        photoP,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.cover,
      );
    }
  }

  void showAlertDialogP(BuildContext context, File photoP) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "JAWA",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text("Toma una fotografía o impórtala de tu galería"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _tomarFoto()),
        IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _seleccionarFoto()),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _seleccionarFoto() async {
    _procesarImagen(
      ImageSource.gallery,
    );
  }

  _tomarFoto() async {
    _procesarImagen(
      ImageSource.camera,
    );
  }

  _procesarImagen(
    ImageSource origen,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);
    if (pickedFile.path == null) {
      Navigator.pop(context);
    } else {
      photoP = File(pickedFile.path);
      if (photoP != null) {
        Navigator.pop(context);
      }
      setState(() {});
    }
  }

//imagen 1
  Widget _mostrarImagen1() {
    if (photo1 != null) {
      return Image.file(
        photo1,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.cover,
      );
    }
  }

  void showAlertDialog1(BuildContext context, File photo1) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "JAWA",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text("Toma una fotografía o impórtala de tu galería"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _tomarFoto1()),
        IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _seleccionarFoto1()),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _seleccionarFoto1() async {
    _procesarImagen1(
      ImageSource.gallery,
    );
  }

  _tomarFoto1() async {
    _procesarImagen1(
      ImageSource.camera,
    );
  }

  _procesarImagen1(
    ImageSource origen,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);
    photo1 = File(pickedFile.path);
    if (photo1 != null) {
      Navigator.pop(context);
    }
    setState(() {});
  }

//imagen 2
  Widget _mostrarImagen2() {
    if (photo2 != null) {
      return Image.file(
        photo2,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.cover,
      );
    }
  }

  void showAlertDialog2(BuildContext context, File photo2) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "JAWA",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text("Toma una fotografía o impórtala de tu galería"),
      actions: [
        IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _tomarFoto2()),
        IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => _seleccionarFoto2()),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _seleccionarFoto2() async {
    _procesarImagen2(
      ImageSource.gallery,
    );
  }

  _tomarFoto2() async {
    _procesarImagen2(
      ImageSource.camera,
    );
  }

  _procesarImagen2(
    ImageSource origen,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);
    photo2 = File(pickedFile.path);

    if (photo2 != null) {
      Navigator.pop(context);
    }
    setState(() {});
  }

  Widget _buildDataForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _textTituloEditingController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título:',
                  hintText:
                      'Agrega el título, si no lo conoces ingresa “Desconocido.',
                  hintStyle: TextStyle(fontSize: 12.0)),
              validator: (value) => value.isEmpty
                  ? 'Por favor ingrese el Título o ingrese como Desconocido'
                  : null,
              onChanged: (value) => titulo = value,
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _textCreadorEditingController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Creador/Autor:',
                  hintText:
                      'Agrega el nombre, si no lo conoces ingresa “Desconocido.',
                  hintStyle: TextStyle(fontSize: 12.0)),
              validator: (value) => value.isEmpty
                  ? 'Por favor ingrese el Creador/Autor o ingrese como Desconocido'
                  : null,
              onChanged: (value) =>
                  creador = value[0].toUpperCase() + value.substring(1),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _textEnlaceEditingController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enlace de contacto del creador/autor:',
                  hintText:
                      '¿Conoces sus redes sociales? Si no es así deja la casilla en blanco.',
                  hintStyle: TextStyle(fontSize: 12.0)),
              onChanged: (value) => enlace = value,
            ),
            SizedBox(
              height: 18.0,
            ),
            dropDownTecnicasFirebase(),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _textUbicacionEditingController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ubicación:',
                  hintText: '¿Donde te encuentras?'),
              validator: (value) =>
                  value.isEmpty ? 'Por favor ingrese la ubicación' : null,
              onChanged: (value) =>
                  ubicacion = value[0].toUpperCase() + value.substring(1),
            ),
            SizedBox(
              height: 18.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotosH(
      BuildContext context, File photo1, File photo2, File photo3) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _mostrarImagen1(),
              ),
            ),
            onTap: () => showAlertDialog1(context, photo1),
          ),
          InkWell(
            child: Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _mostrarImagen2(),
              ),
            ),
            onTap: () => showAlertDialog2(context, photo2),
          ),
        ],
      ),
    );
  }

  Widget _buildbuttons(
    BuildContext context,
    point,
    urlFoto,
    urlFoto1,
    urlFoto2,
  ) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.pushNamed(context, 'home'),
            child: Container(
              width: 100,
              child: Center(
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              await _subirImagendestacada(context);
              await _subirImagen1(context);
              await _subirImagen2(context);
              _enviar(
                context,
                point,
              );
            },
            child: Container(
              width: 100,
              child: Center(
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _subirImagendestacada(BuildContext context) async {
    if (photoP != null) {
      final StorageReference fireStoreRef = FirebaseStorage.instance
          .ref()
          .child('$ubicacion')
          .child('$creador')
          .child("${photoP.path}");
      final StorageUploadTask task = fireStoreRef.putFile(
          photoP, StorageMetadata(contentType: 'image/jpeg'));
      await task.onComplete.then((onValue) {
        setState(() {
          onValue.ref
              .getDownloadURL()
              .then((value) => urlFoto = value.toString());
        });
      });
    }
  }

  Future<void> _subirImagen1(BuildContext context) async {
    if (photo1 != null) {
      final StorageReference fireStoreRef = FirebaseStorage.instance
          .ref()
          .child('$ubicacion')
          .child('$creador')
          .child('${photo1.path}');
      final StorageUploadTask task = fireStoreRef.putFile(
          photo1, StorageMetadata(contentType: 'image/jpeg'));
      await task.onComplete.then((onValue) {
        setState(() {
          onValue.ref
              .getDownloadURL()
              .then((value) => urlFoto1 = value.toString());
        });
      });
    }
  }

  Future<void> _subirImagen2(
    BuildContext context,
  ) async {
    if (photo2 != null) {
      final StorageReference fireStoreRef = FirebaseStorage.instance
          .ref()
          .child('$ubicacion')
          .child('$creador')
          .child('${photo2.path}');
      final StorageUploadTask task = fireStoreRef.putFile(
          photo2, StorageMetadata(contentType: 'image/jpeg'));
      await task.onComplete.then((onValue) {
        setState(() {
          onValue.ref
              .getDownloadURL()
              .then((value) => urlFoto2 = value.toString());
        });
      });
    }
  }

  _enviar(BuildContext context, point) async {
    print(creador);
    if (_validate()) {
      print('url de la foto $urlFoto1');
      await FirebaseFirestore.instance.collection('ingresos').doc().set({
        'creador/autor': creador,
        'enlace': enlace,
        'fecha de captura': DateTime.now(),
        'imagen destacada': urlFoto,
        'imagenes': [urlFoto1, urlFoto2],
        'localizacion': point.data['geopoint'],
        // 'soporte': sopSel.soporte,
        'titulo': titulo,
        // 'tematica': tematica,
        'tecnica': tecnica,
        'uid': widget.uid,
        'ubicacion': ubicacion
      });
      setState(() {
        _ackAlert(context);
      });
    } else {
      utils.showAlert(context, 'Los datos ingresados son incorrectos');
    }
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información Agregada'),
          content: const Text(
              'La información suministrada será revisada y posteriormente agregada a nuestra base de datos  '),
          actions: <Widget>[
            FlatButton(
              child: Text('Continuar'),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
          ],
        );
      },
    );
  }

  dropDownTecnicasFirebase() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tecnicas').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            Center(
              child: const CupertinoActivityIndicator(),
            );
          return Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: tecnica,
                isDense: true,
                isExpanded: true,
                hint: Text('Técnicas'),
                onChanged: (newValue) {
                  setState(() {
                    tecnica = newValue;
                  });
                },
                items: snapshot.data != null
                    ? snapshot.data.docs.map((DocumentSnapshot document) {
                        return new DropdownMenuItem<String>(
                            value: document.data()['nombre'].toString(),
                            child: new Container(
                              height: 15.0,
                              //color: primaryColor,
                              child: new Text(
                                document.data()['nombre'].toString(),
                                style: TextStyle(color: Color(0xffFFBA2E)),
                              ),
                            ));
                      }).toList()
                    : DropdownMenuItem(
                        value: 'null',
                        child: new Container(
                          height: 15.0,
                          child: new Text('null'),
                        ),
                      ),
              ),
            ),
          );
        });
  }
}
