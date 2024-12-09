import 'dart:math';

import 'package:jawaaplicacion/src/widgets/geoflutterfire/models/point.dart';

class MathUtils {
  MathUtils() {
    for (var i = 0; i < base32Codes.length; i++) {
      base32CodesDic.putIfAbsent(base32Codes[i], () => i);
    }
  }
  static const base32Codes = '0123456789bcdefghjkmnpqrstuvwxyz';
  Map<String, int> base32CodesDic = {};

  String encodeAuto = 'auto';

  ///
  /// Significant Figure Hash Length
  ///
  /// This is a quick and dirty lookup to figure out how long our hash
  /// should be in order to guarantee a certain amount of trailing
  /// significant figures. This was calculated by determining the error:
  /// 45/2^(n-1) where n is the number of bits for a latitude or
  /// longitude. Key is # of desired sig figs, value is minimum length of
  /// the geohash.
  /// @type Array
  // Desired sig figs:    0  1  2  3   4   5   6   7   8   9  10
  List<int> sigfigHashLength = [0, 5, 7, 8, 11, 12, 13, 15, 16, 17, 18];

  ///
  /// Encode
  /// Create a geohash from latitude and longitude
  /// that is 'number of chars' long
  String encode(double latitude, double longitude, double numberOfChars) {
    if (numberOfChars == double.parse(encodeAuto)) {
      if (latitude.runtimeType == double || longitude.runtimeType == double) {
        throw Exception('string notation required for auto precision.');
      }
      final decSigFigsLat = latitude.toString().split('.')[1].length;
      final decSigFigsLon = longitude.toString().split('.')[1].length;
      final int numberOfSigFigs = max(decSigFigsLat, decSigFigsLon);
      numberOfChars =
          double.parse(sigfigHashLength[numberOfSigFigs].toString());
    } else {
      numberOfChars ??= 9;
    }

    final chars = [];
    var bits = 0;
    var bitsTotal = 0;
    var hashValue = 0;
    var maxLat = 90 as double;
    var minLat = -90 as double;
    var maxLon = 180 as double;
    var minLon = -180 as double;
    double mid;

    while (chars.length < numberOfChars) {
      if (bitsTotal % 2 == 0) {
        mid = (maxLon + minLon) / 2;
        if (longitude > mid) {
          hashValue = (hashValue << 1) + 1;
          minLon = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLon = mid;
        }
      } else {
        mid = (maxLat + minLat) / 2;
        if (latitude > mid) {
          hashValue = (hashValue << 1) + 1;
          minLat = mid;
        } else {
          hashValue = (hashValue << 1) + 0;
          maxLat = mid;
        }
      }

      bits++;
      bitsTotal++;
      if (bits == 5) {
        final code = base32Codes[hashValue];
        chars.add(code);
        bits = 0;
        hashValue = 0;
      }
    }

    return chars.join();
  }

  ///
  /// Decode Bounding box
  ///
  /// Decode a hashString into a bound box that matches it.
  /// Data returned in a List [minLat, minLon, maxLat, maxLon]
  List<double> decodeBbox(String hashString) {
    var isLon = true;
    var maxLat = 90 as double;
    var minLat = -90 as double;
    var maxLon = 180 as double;
    var minLon = -180 as double;
    double mid;

    int? hashValue = 0;
    for (var i = 0, l = hashString.length; i < l; i++) {
      final code = hashString[i].toLowerCase();
      hashValue = base32CodesDic[code];

      for (var bits = 4; bits >= 0; bits--) {
        final bit = (hashValue! >> bits) & 1;
        if (isLon) {
          mid = (maxLon + minLon) / 2;
          if (bit == 1) {
            minLon = mid;
          } else {
            maxLon = mid;
          }
        } else {
          mid = (maxLat + minLat) / 2;
          if (bit == 1) {
            minLat = mid;
          } else {
            maxLat = mid;
          }
        }
        isLon = !isLon;
      }
    }
    return [minLat, minLon, maxLat, maxLon];
  }

  ///
  /// Decode a [hashString] into a pair of latitude and longitude.
  /// A map is returned with keys 'latitude', 'longitude','latitudeError','longitudeError'
  Map<String, double> decode(String hashString) {
    final bbox = decodeBbox(hashString);
    final lat = (bbox[0] + bbox[2]) / 2;
    final lon = (bbox[1] + bbox[3]) / 2;
    final latErr = bbox[2] - lat;
    final lonErr = bbox[3] - lon;
    return {
      'latitude': lat,
      'longitude': lon,
      'latitudeError': latErr,
      'longitudeError': lonErr,
    };
  }

  ///
  /// Neighbor
  ///
  /// Find neighbor of a geohash string in certain direction.
  /// Direction is a two-element array, i.e. [1,0] means north, [-1,-1] means southwest.
  ///
  /// direction [lat, lon], i.e.
  /// [1,0] - north
  /// [1,1] - northeast
  String neighbor(String hashString, var direction) {
    final lonLat = decode(hashString);
    final neighborLat = lonLat['latitude']! +
        num.parse((direction[0] * lonLat['latitudeError'] * 2).toString());
    final neighborLon = lonLat['longitude']! +
        num.parse((direction[1] * lonLat['longitudeError'] * 2).toString());
    return encode(
      neighborLat,
      neighborLon,
      double.parse(hashString.length.toString()),
    );
  }

  ///
  /// Neighbors
  /// Returns all neighbors' hashstrings clockwise from north around to northwest
  /// 7 0 1
  /// 6 X 2
  /// 5 4 3
  List<String> neighbors(String hashString) {
    final hashStringLength = hashString.length;
    final lonlat = decode(hashString);
    final lat = lonlat['latitude'];
    final lon = lonlat['longitude'];
    final latErr = lonlat['latitudeError']! * 2;
    final lonErr = lonlat['longitudeError']! * 2;

    num neighborLat;
    num neighborLon;

    String encodeNeighbor(num neighborLatDir, num neighborLonDir) {
      neighborLat = lat! + neighborLatDir * latErr;
      neighborLon = lon! + neighborLonDir * lonErr;
      return encode(
        double.parse(neighborLat.toString()),
        double.parse(neighborLon.toString()),
        double.parse(hashStringLength.toString()),
      );
    }

    final neighborHashList = [
      encodeNeighbor(1, 0),
      encodeNeighbor(1, 1),
      encodeNeighbor(0, 1),
      encodeNeighbor(-1, 1),
      encodeNeighbor(-1, 0),
      encodeNeighbor(-1, -1),
      encodeNeighbor(0, -1),
      encodeNeighbor(1, -1),
    ];

    return neighborHashList;
  }

  static int setPrecision(double km) {
    /*
      * 1	≤ 5,000km	×	5,000km
      * 2	≤ 1,250km	×	625km
      * 3	≤ 156km	×	156km
      * 4	≤ 39.1km	×	19.5km
      * 5	≤ 4.89km	×	4.89km
      * 6	≤ 1.22km	×	0.61km
      * 7	≤ 153m	×	153m
      * 8	≤ 38.2m	×	19.1m
      * 9	≤ 4.77m	×	4.77m
      *
     */

    if (km <= 0.00477) {
      return 9;
    } else if (km <= 0.0382) {
      return 8;
    } else if (km <= 0.153) {
      return 7;
    } else if (km <= 1.22) {
      return 6;
    } else if (km <= 4.89) {
      return 5;
    } else if (km <= 39.1) {
      return 4;
    } else if (km <= 156) {
      return 3;
    } else if (km <= 1250) {
      return 2;
    } else {
      return 1;
    }
  }

  static const double maxSupportedRadius = 8587;

  // Length of a degree latitude at the equator
  static const double metersPerDegreeLatitude = 110574;

  // The equatorial circumference of the earth in meters
  static const double earthMeridionalCircumference = 40007860;

  // The equatorial radius of the earth in meters
  static const double earthEqRadius = 6378137;

  // The meridional radius of the earth in meters
  static const double earthPolarRadius = 6357852.3;

  /* The following value assumes a polar radius of
     * r_p = 6356752.3
     * and an equatorial radius of
     * r_e = 6378137
     * The value is calculated as e2 == (r_e^2 - r_p^2)/(r_e^2)
     * Use exact value to avoid rounding errors
     */
  static const double earthE2 = 0.00669447819799;

  // Cutoff for floating point calculations
  static const double epsilon = 1e-12;

  /// distance in km
  static double kmDistance(Coordinates location1, Coordinates location2) {
    return kmCalcDistance(
      location1.latitude,
      location1.longitude,
      location2.latitude,
      location2.longitude,
    );
  }

  /// distance in km
  static double kmCalcDistance(
    double lat1,
    double long1,
    double lat2,
    double long2,
  ) {
    // Earth's mean radius in meters
    const radius = (earthEqRadius + earthPolarRadius) / 2;
    final latDelta = _toRadians(lat1 - lat2);
    final lonDelta = _toRadians(long1 - long2);

    final a = (sin(latDelta / 2) * sin(latDelta / 2)) +
        (cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(lonDelta / 2) *
            sin(lonDelta / 2));
    final distance = radius * 2 * atan2(sqrt(a), sqrt(1 - a)) / 1000;
    return double.parse(distance.toStringAsFixed(3));
  }

  static double _toRadians(double num) {
    return num * (pi / 180.0);
  }
}
