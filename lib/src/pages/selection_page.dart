import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jawaaplicacion/src/models/avatar_model.dart';
import 'package:jawaaplicacion/src/providers/firebase_storage_provider.dart';
import 'package:jawaaplicacion/src/providers/firestore_provider.dart';
import 'package:jawaaplicacion/src/providers/image_picker_provider.dart';
import 'package:jawaaplicacion/src/widgets/avatar_widget.dart';
import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';
import 'package:provider/provider.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. Get image from picker
      final imagePicker =
          Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final storage = Provider.of<FirebaseStorageService>(context);
        final downloadUrl = await storage.uploadAvatar(file: file);
        // 3. Save url to Firestore
        final database = Provider.of<FirestoreService>(context);
        await database.setAvatarReference(AvatarReference(downloadUrl));
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 135.0),
              child: _buildUserInfo(context),
            )),
        Padding(
          padding: EdgeInsets.only(top: 260),
          child: _buildStreamItems(),
        ),
        CustomAppBarComp(),
      ],
    ));
  }

  Widget _buildUserInfo(BuildContext context) {
    final database = Provider.of<FirestoreService>(context);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 60,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context),
        );
      },
    );
  }

  _buildStreamItems() {
    Color _color = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ingresos').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          default:
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> data =
                    snapshot.data.docs[index].data();
                final dataID = snapshot.data.docs[index].id;
                return Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage(
                          height: size.height * 0.5,
                          placeholder: AssetImage('assets/images/no-image.png'),
                          image: NetworkImage(
                            data['imagen destacada'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Center(
                        child: Text(
                          data['creador/autor'],
                        ),
                      ),
                      subtitle: Center(
                        child: Text(
                          data['ubicacion'],
                        ),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                      onTap: () => Navigator.pushNamed(context, 'content',
                          arguments: data),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildDeleteIcon(context, dataID),
                        _buildApprovedIcon(
                          context,
                          data,
                          dataID,
                          _color,
                        ),
                        Text(
                          data['estado'],
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
        }
      },
    );
  }

  Widget _buildDeleteIcon(BuildContext context, dataID) {
    final id = dataID;
    return Container(
      child: IconButton(
          icon: Icon(CupertinoIcons.delete), onPressed: () => rejectItem(id)),
    );
  }

  Widget _buildApprovedIcon(
    BuildContext context,
    Map<String, dynamic> data,
    dataID,
    Color _color,
  ) {
    final docs = data;
    final id = dataID;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: IconButton(
              icon: Icon(
                CupertinoIcons.check_mark,
                color: _color,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  updateStateItem(id);
                  approvedItem(docs);
                });
              }),
        ),
      ],
    );
  }
}

Future<void> rejectItem(String id) {
  return FirebaseFirestore.instance.collection('ingresos').doc(id).delete();
}

Future<void> approvedItem(
  Map<String, dynamic> docs,
) async {
  await FirebaseFirestore.instance.collection('aprobados').doc().set(docs);
}

Future<void> updateStateItem(String id) async {
  await FirebaseFirestore.instance
      .collection('ingresos')
      .doc(id)
      .update({'estado': 'Aprobado'});
}
