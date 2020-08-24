import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jawaaplicacion/src/widgets/custom_bottom_navigatorbar_simp.dart';

class MapsPage extends StatefulWidget {
  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(4.5970, -74.0729);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  populateClients() {
    FirebaseFirestore.instance.collection('ingresos').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
    setState(() {});
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(request, requestId) {
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    //nuevo marcador
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          request['localizacion'].latitude, request['localizacion'].longitude),
      infoWindow: InfoWindow(
          title: request['ubicacion'],
          snippet: request['creador/autor'],
          onTap: () {}),
    );
    setState(() {
      markers[markerId] = marker;
      // print(markerId);
    });
  }

  @override
  void initState() {
    setState(() {
      populateClients();
    });

    super.initState();
  }

  MapType _defaultMapType = MapType.normal;

  // void _changeMapType() {
  //   setState(() {
  //     _defaultMapType =
  //         _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
  //   });
  // }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        icon: BitmapDescriptor.defaultMarker,
      ));
      Navigator.pushNamed(context, 'add', arguments: _lastMapPosition);
    });
  }

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void getCurrentPosition() async {
    await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('____posicion___');
    print('$position');
  }

  // void placemarkFromAddress() async {
  //   List<Placemark> placemark =
  //       await Geolocator().placemarkFromAddress("La Candelaria, Bogotá");
  //   print('____la patria___');
  // }

  @override
  Widget build(BuildContext context) {
    getCurrentPosition();

    //placemarkFromAddress();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 55),
            child: GoogleMap(
              markers: Set<Marker>.of(markers.values),
              onCameraMove: _onCameraMove,
              mapType: _defaultMapType,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 168),
                //   child: FloatingActionButton(

                //     heroTag: null,
                //     onPressed: () {
                //       _changeMapType();
                //       // print('Cambiar tipo de mapa');
                //     },
                //     materialTapTargetSize: MaterialTapTargetSize.padded,
                //     backgroundColor: Colors.orange,
                //     child: const Icon(CupertinoIcons.refresh, size: 45.0),
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(bottom: 0, child: CustomBottomNavigatorBarComp()),
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: Container(
              width: 0,
              height: 50,
              child: FloatingActionButton(
                elevation: 2,
                heroTag: null,
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.orange,
                child: const Icon(CupertinoIcons.add, size: 40.0),
              ),
            ),
          ),
          _buildListViewItems(),
        ],
      ),
    );
  }

  _buildListViewItems() {
    Query query = FirebaseFirestore.instance.collection('ingresos');
    return Container(
      margin: EdgeInsets.only(bottom: 165),
      alignment: Alignment.bottomCenter,
      child: StreamBuilder(
        stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final data = snapshot.data;
          if (snapshot.hasError) return Text(snapshot.error);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Sin conexion');
            case ConnectionState.waiting:
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.active:
              return _buildLisTileItems(context, data);
            case ConnectionState.done:
              return Text('Listo');
          }
          return null; // unreachable
        },
      ),
    );
  }

  _buildLisTileItems(BuildContext context, QuerySnapshot data) {
    return Container(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final lat = data.docs[index].data()['localizacion'].latitude;
            final long = data.docs[index].data()['localizacion'].longitude;
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: GestureDetector(
                onTap: () {
                  _gotoLocation(lat, long);
                },
                onDoubleTap: () {
                  final dataL = data.docs[index];
                  Navigator.pushNamed(context, 'content', arguments: dataL);
                },
                child: Container(
                  child: FittedBox(
                    child: Material(
                      color: Colors.white,
                      elevation: 0.5,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white),
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(data.docs[index]
                                    .data()['imagen destacada']),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(data.docs[index].data()['tecnica'],
                                    style: TextStyle(color: Colors.orange),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  data.docs[index].data()['creador/autor'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 25,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
