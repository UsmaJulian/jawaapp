import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';
import 'package:uuid/uuid.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.uid});

  final uid;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: widget.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Container(
          width: 150,
          height: 150,
          child: GestureDetector(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: "assets/images/no-image.png",
                    image: "${snapshot.data.docs[0].data()['photoURL']}"),
              ),
            ),
            onTap: () async {
              File _avatarImage;
              final picker = ImagePicker();
              final pickedFileAvatar =
                  await picker.getImage(source: ImageSource.gallery);
              setState(() {
                _avatarImage = File(pickedFileAvatar.path);
              });
              if (_avatarImage != null) {
                var imageAvatar = Uuid().v1();
                var imageAvatarPath =
                    '/user/avatar/${widget.uid}/$imageAvatar.jpg';
                final StorageReference storageReference =
                    FirebaseStorage().ref().child(imageAvatarPath);
                final StorageUploadTask uploadTask =
                    storageReference.putFile(_avatarImage);
                final StreamSubscription<StorageTaskEvent> streamSubscription =
                    uploadTask.events.listen((event) {
                  print('EVENT ${event.type}');
                });
                await uploadTask.onComplete;
                streamSubscription.cancel();
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                    .update(
                  {
                    "photoURL":
                        (await storageReference.getDownloadURL()).toString()
                  },
                );
              } else {
                print('error');
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildUserItems(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
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
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data.docs[index].data();
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
