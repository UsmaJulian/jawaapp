import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:jawaaplicacion/src/widgets/custom_appbar_comp_widget.dart';
import 'package:uuid/uuid.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.uid});

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
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[100],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: double.infinity,
                  height: 120,
                ),
                _buildUserInfo(context),
                _buildUserItems(context),
              ],
            ),
          ),
          const CustomAppBarComp(),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        return SizedBox(
          width: 150,
          height: 150,
          child: GestureDetector(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/no-image.png',
                  image:
                      "${(snapshot.data != null) ? snapshot.data.docs[0].data()['photoURL'] : "https://res.cloudinary.com/det3hixp6/image/upload/v1670263919/logo_jygjvf.png"}",
                ),
              ),
            ),
            onTap: () async {
              File? avatarImage;
              final picker = ImagePicker();
              final pickedFileAvatar =
                  await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                avatarImage = File(pickedFileAvatar!.path);
              });
              if (avatarImage != null) {
                final imageAvatar = const Uuid().v1();
                final imageAvatarPath =
                    '/user/avatar/${widget.uid}/$imageAvatar.jpg';
                final storageReference =
                    FirebaseStorage.instance.ref().child(imageAvatarPath);
                final uploadTask = storageReference.putFile(avatarImage!);
                final StreamSubscription streamSubscription =
                    uploadTask.snapshotEvents.listen((event) {
                  print('EVENT $event');
                });
                await uploadTask.whenComplete(() async {
                  await streamSubscription.cancel();
                  final downloadUrl = await storageReference.getDownloadURL();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid.toString())
                      .update({'photoURL': downloadUrl});
                });
                await streamSubscription.cancel();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid.toString())
                    .update(
                  {
                    'photoURL': await storageReference.getDownloadURL(),
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

    return SizedBox(
      height: size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ingresos')
            // .where('uid', isEqualTo: widget.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              return ListView.builder(
                itemCount: int.parse(snapshot.data!.docs.length.toString()),
                itemBuilder: (BuildContext context, int index) {
                  final data = snapshot.data!.docs[index].data();
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFBA2E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                'assets/images/no-image.png',
                              ),
                              image: NetworkImage(
                                data['imagen destacada'].toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Center(
                          child: Text(
                            data['creador'].toString(),
                          ),
                        ),
                        subtitle: Center(
                          child: Text(
                            data['ubicacion'].toString(),
                          ),
                        ),
                        trailing: const Icon(CupertinoIcons.right_chevron),
                        onTap: () => Navigator.pushNamed(
                          context,
                          'content',
                          arguments: data,
                        ),
                      ),
                      const Divider(),
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
