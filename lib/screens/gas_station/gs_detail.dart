import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class GasDetail extends StatefulWidget {
  GasDetail({this.data});
  final DataSpbg data;
  @override
  GasDetailState createState() => GasDetailState(data);
}

class GasDetailState extends State<GasDetail> {
  DataSpbg data;
  GasDetailState(this.data);
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  String icon = "assets/currentlocation_icon.png";

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('title_bar_spbg'),
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
                target: LatLng(double.parse(data.location.latitude),
                    double.parse(data.location.longitude)),
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                      draggable: true,
                      markerId: MarkerId("1"),
                      position: LatLng(double.parse(data.location.latitude),
                          double.parse(data.location.longitude)),
                      icon: BitmapDescriptor.defaultMarker,
                      infoWindow: InfoWindow(
                        title: data.title,
                      ),
                      onTap: () {
                        _launchURL(
                            "google.navigation:q=${double.parse(data.location.latitude)},${double.parse(data.location.longitude)}");
                      })
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 15),
                      Icon(
                        Icons.location_on,
                        size: 35,
                        color: Color(0xFFFF972F),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: Text(
                              data.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: Text(
                              '${data.location.latitude}, ${data.location.longitude}',
                              style: TextStyle(
                                  color: Color(0xFF5C727D),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Text(
                      data.address,
                      style: TextStyle(
                        color: Color(0xFF5C727D),
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
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
