import 'package:cloud_firestore/cloud_firestore.dart';

class DistanceDocSnapshot<T> {
  DistanceDocSnapshot({
    required this.documentSnapshot,
    required this.kmDistance,
  });
  final DocumentSnapshot<T> documentSnapshot;
  final double kmDistance;
}
