import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/collection/base.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/distance_doc_snapshot.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/point.dart';

class GeoFireCollectionWithConverterRef<T> extends BaseGeoFireCollectionRef<T> {
  GeoFireCollectionWithConverterRef(super.collectionReference);

  Stream<List<DocumentSnapshot<T>>> within({
    required GeoFirePoint center,
    required double radius,
    required String field,
    required GeoPoint Function(T) geopointFrom,
    bool? strictMode,
  }) {
    return protectedWithin(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: geopointFrom,
      strictMode: strictMode,
    );
  }

  Stream<List<DistanceDocSnapshot<T>>> withinWithDistance({
    required GeoFirePoint center,
    required double radius,
    required String field,
    required GeoPoint Function(T) geopointFrom,
    bool? strictMode,
  }) {
    return protectedWithinWithDistance(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: geopointFrom,
      strictMode: strictMode,
    );
  }
}
