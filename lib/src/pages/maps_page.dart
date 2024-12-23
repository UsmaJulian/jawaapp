import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jawaaplicacion/src/widgets/custom_bottom_navigatorbar_simp.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  MapsPageState createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> with AfterLayoutMixin<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  static const LatLng _center = LatLng(4.5970, -74.0729);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  populateClients() {
    FirebaseFirestore.instance.collection('ingresos').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
    setState(() {});
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(request, requestId) {
    final markerIdVal = requestId;
    final markerId = MarkerId(markerIdVal.toString());
    //nuevo marcador
    final marker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(request['localizacion'].latitude.toString()),
        double.parse(request['localizacion'].longitude.toString()),
      ),
      infoWindow: InfoWindow(
        title: request['ubicacion'].toString(),
        snippet: request['creador'].toString(),
        onTap: () {},
      ),
    );
    setState(() {
      markers[markerId] = marker;
      // print(markerId);
    });
  }

  @override
  void initState() {
    setState(populateClients);

    super.initState();
  }

  final MapType _defaultMapType = MapType.normal;

  // void _changeMapType() {
  //   setState(() {
  //     _defaultMapType =
  //         _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
  //   });
  // }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                .toString(),
          ),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
      Navigator.pushNamed(
        context,
        'add',
        arguments:
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      );
    });
  }

  final Set<Marker> _markers = {};

  // ignore: unused_field
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  getCurrentPos() async {
    try {
      final position = await Geolocator.getCurrentPosition();

      setState(() {
        _currentPosition = position;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  // void placemarkFromAddress() async {
  //   List<Placemark> placemark =
  //       await Geolocator().placemarkFromAddress("La Candelaria, Bogotá");
  //   print('____la patria___');
  // }
  @override
  void afterFirstLayout(BuildContext context) {
    determinePosition();
    getCurrentPos();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    determinePosition();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Permisos de ubicación denegados.');
      }
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          if (_currentPosition == null)
            const Center(
              child: CupertinoActivityIndicator(),
            )
          else
            Container(
              margin: const EdgeInsets.only(
                top: 30,
              ),
              padding: const EdgeInsets.only(top: 55, bottom: 60),
              child: GoogleMap(
                markers: Set<Marker>.of(markers.values),
                onCameraMove: _onCameraMove,
                mapType: _defaultMapType,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 18,
                ),
              ),
            ),

          // Align(
          //   alignment: Alignment.topRight,
          //   child: Column(
          //     children: <Widget>[
          //       // Padding(
          //       //   padding: const EdgeInsets.only(top: 168),
          //       //   child: FloatingActionButton(

          //       //     heroTag: null,
          //       //     onPressed: () {
          //       //       _changeMapType();
          //       //       // print('Cambiar tipo de mapa');
          //       //     },
          //       //     materialTapTargetSize: MaterialTapTargetSize.padded,
          //       //     backgroundColor: Color(0xffFFBA2E),
          //       //     child: const Icon(CupertinoIcons.refresh, size: 45.0),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          const Positioned(bottom: 0, child: CustomBottomNavigatorBarComp()),
          Positioned(
            bottom: 90,
            left: 50,
            right: 50,
            child: SizedBox(
              width: 0,
              height: 50,
              child: FloatingActionButton(
                elevation: 2,
                heroTag: null,
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: const Color(0xffFFBA2E),
                child: const Icon(
                  CupertinoIcons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildListViewItems(),
        ],
      ),
    );
  }

  Container _buildListViewItems() {
    final query = FirebaseFirestore.instance.collection('ingresos');
    return Container(
      margin: const EdgeInsets.only(bottom: 165),
      alignment: Alignment.bottomCenter,
      child: StreamBuilder(
        stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final data = snapshot.data;
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Sin conexion');
            case ConnectionState.waiting:
              return Center(
                child: Container(
                  child: const CircularProgressIndicator(),
                ),
              );
            case ConnectionState.active:
              return _buildLisTileItems(context, data as QuerySnapshot);
            case ConnectionState.done:
              return const Text('Listo');
          }
        },
      ),
    );
  }

  SizedBox _buildLisTileItems(BuildContext context, QuerySnapshot data) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.docs.length,
        itemBuilder: (BuildContext context, int index) {
          final lat = data.docs[index]['localizacion'].latitude;
          final long = data.docs[index]['localizacion'].longitude;
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: GestureDetector(
              onTap: () {
                _gotoLocation(
                  double.parse(lat.toString()),
                  double.parse(long.toString()),
                );
              },
              onDoubleTap: () {
                final dataL = data.docs[index].data();
                Navigator.pushNamed(context, 'content', arguments: dataL);
              },
              child: Container(
                child: FittedBox(
                  child: Material(
                    color: Colors.white,
                    elevation: 0.5,
                    borderRadius: BorderRadius.circular(24),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                data.docs[index]['imagen destacada'].toString(),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                data.docs[index]['tecnica'].toString(),
                                style: const TextStyle(
                                  color: Color(0xffFFBA2E),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                data.docs[index]['creador'].toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 12),
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
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 25,
          tilt: 50,
          bearing: 45,
        ),
      ),
    );
  }
}
