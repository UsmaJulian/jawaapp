import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:jawaaplicacion/src/models/avatar_model.dart';
import 'package:jawaaplicacion/src/providers/firebase_path_provider.dart';

class FirestoreService {
  FirestoreService({@required this.uid}) : assert(uid != null);
  final String? uid;

  // Sets the avatar download url
  Future<void> setAvatarReference(AvatarReference avatarReference) async {
    final path = FirestorePath.avatar(uid!);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(avatarReference.toMap());
  }

  // Reads the current avatar download url
  Stream<AvatarReference> avatarReferenceStream() {
    final path = FirestorePath.avatar(uid!);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => AvatarReference.fromMap(snapshot.data()));
  }
}
