import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/collection/base.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/distance_doc_snapshot.dart';
import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/point.dart';

class GeoFireCollectionRef
    extends BaseGeoFireCollectionRef<Map<String, dynamic>> {
  GeoFireCollectionRef(super.collectionReference);

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> within({
    required GeoFirePoint center,
    required double radius,
    required String field,
    bool? strictMode,
  }) {
    return protectedWithin(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: (snapData) => geopointFromMap(
        field: field,
        snapData: snapData,
      ),
      strictMode: strictMode,
    );
  }

  Stream<List<DistanceDocSnapshot<Map<String, dynamic>>>> withinWithDistance({
    required GeoFirePoint center,
    required double radius,
    required String field,
    bool? strictMode,
  }) {
    return protectedWithinWithDistance(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: (snapData) => geopointFromMap(
        field: field,
        snapData: snapData,
      ),
      strictMode: strictMode,
    );
  }

  @visibleForTesting
  static GeoPoint? geopointFromMap({
    required String field,
    required Map<String, dynamic> snapData,
  }) {
    // split and fetch geoPoint from the nested Map
    final fieldList = field.split('.');
    var geoPointField = snapData[fieldList[0]] as Map<dynamic, dynamic>?;
    if (fieldList.length > 1) {
      for (var i = 1; i < fieldList.length; i++) {
        geoPointField = geoPointField?[fieldList[i]] as Map<dynamic, dynamic>?;
      }
    }
    return geoPointField?['geopoint'] as GeoPoint?;
  }
}
