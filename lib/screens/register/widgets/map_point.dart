import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPoint extends StatefulWidget {
  @override
  MapPointState createState() => MapPointState();
}

class MapPointState extends State<MapPoint> {
  GoogleMapController mapController;
  String position = '';
  double lat = -6.142168799999999;
  double lang = 107.1416825;
  Completer<GoogleMapController> _controller = Completer();
  String icon = "assets/currentlocation_icon.png";

  void _onMapCreated(GoogleMapController controller) {
    _getCurrentLocation();
    _controller.complete(controller);
  }

  void _updatePosition(CameraPosition _position) {
    setState(() {
      position = '${_position.target.latitude},${_position.target.longitude}';
      lat = _position.target.latitude;
      lang = _position.target.longitude;
    });
    // Position newMarkerPosition = Position(
    //     latitude: _position.target.latitude,
    //     longitude: _position.target.longitude);
    // Marker marker = markers["1"];

    // setState(() {
    //   markers["1"] = marker.copyWith(
    //       positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    // });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        lat = position.latitude;
        lang = position.longitude;
      });
    }).catchError((e) {
      //print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('df_title_map_location_selector'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 0, bottom: 1),
            child: GoogleMap(
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lang),
                zoom: 15.0,
              ),
              onCameraMove: ((_position) => _updatePosition(_position)),
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                    draggable: true,
                    markerId: MarkerId("1"),
                    position: LatLng(lat, lang),
                    icon: BitmapDescriptor.defaultMarker,
                    // infoWindow: InfoWindow(
                    //   title: data.title,
                    // ),
                    // onTap: () {
                    //   _launchURL(
                    //       "google.navigation:q=${double.parse(data.location.latitude)},${double.parse(data.location.longitude)}");
                    // }
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 8,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Text(
                      position,
                      style: TextStyle(
                        color: Color(0xFF5C727D),
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      String sendBack = position;
                      Navigator.pop(context, sendBack);
                    },
                    child: Center(child: Text('OK')),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
