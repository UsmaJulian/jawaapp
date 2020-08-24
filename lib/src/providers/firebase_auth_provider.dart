import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserAuth {
  const UserAuth({@required this.uid});
  final String uid;
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  UserAuth _userFromFirebase(User user) {
    return user == null ? null : UserAuth(uid: user.uid);
  }

  Stream<UserAuth> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<UserAuth> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user.uid)
        .set({
      'photoURL': 'https://via.placeholder.com/150',
      'uid': authResult.user.uid
    });
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
