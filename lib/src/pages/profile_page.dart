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

class ProfilePage extends StatefulWidget {
  ProfilePage({this.uid});

  final uid;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[100],
        ),
        SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 120,
                ),
                _buildUserInfo(context),
                _buildUserItems(context),
              ]),
        ),
        CustomAppBarComp(),
      ]),
    );
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

  Widget _buildUserItems(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('ingresos')
            // .where('uid', isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            default:
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data.documents[index];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/no-image.png'),
                              image: NetworkImage(
                                data['imagen destacada'],
                              ),
                              fit: BoxFit.cover,
                            ),
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
                      Divider(),
                    ],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
