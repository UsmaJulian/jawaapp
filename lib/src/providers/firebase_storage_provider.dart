import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:jawaaplicacion/src/providers/firebase_path_provider.dart';

class FirebaseStorageService {
  FirebaseStorageService({@required this.uid}) : assert(uid != null);
  final String? uid;

  /// Upload an avatar from file
  Future<String> uploadAvatar({
    @required File? file,
  }) async =>
      upload(
        file: file,
        path: '${FirestorePath.avatar(uid!)}/avatar.png',
        contentType: 'image/png',
      );

  /// Generic file upload for any [path] and [contentType]
  Future<String> upload({
    @required File? file,
    @required String? path,
    @required String? contentType,
  }) async {
    print('uploading to: $path');
    final storageReference = FirebaseStorage.instance.ref().child(path!);
    final uploadTask = storageReference.putFile(
      file!,
    );
    final snapshot = await uploadTask;
    // if (snapshot.error != null) {
    //   print('upload error code: ${snapshot.error}');
    //   throw snapshot.error;
    // }
    // Url used to download file/image
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print('downloadUrl: $downloadUrl');
    return downloadUrl;
  }
}
