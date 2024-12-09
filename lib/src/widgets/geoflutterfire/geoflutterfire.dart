import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/collection/default.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/collection/with_converter.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/point.dart';

class Geoflutterfire {
  Geoflutterfire();

  GeoFireCollectionRef collection({
    required Query<Map<String, dynamic>> collectionRef,
  }) {
    return GeoFireCollectionRef(collectionRef);
  }

  GeoFireCollectionWithConverterRef<T> collectionWithConverter<T>({
    required Query<T> collectionRef,
  }) {
    return GeoFireCollectionWithConverterRef<T>(collectionRef);
  }

  GeoFireCollectionRef customCollection({
    required Query<Map<String, dynamic>> collectionRef,
  }) {
    return GeoFireCollectionRef(collectionRef);
  }

  GeoFirePoint point({required double latitude, required double longitude}) {
    return GeoFirePoint(latitude, longitude);
  }
}
