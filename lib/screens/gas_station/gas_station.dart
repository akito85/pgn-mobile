import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/models/spbg_model.dart';
import 'package:pgn_mobile/screens/gas_station/gs_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class GasStation extends StatefulWidget {
  @override
  GasStationState createState() => GasStationState();
}

class GasStationState extends State<GasStation> {
  @override
  Widget build(BuildContext context) {
    fetchPost(context);
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/new_backgound.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          _buildContent(context, fetchPost(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, Future<GetSpbg> getSpbg) {
    return FutureBuilder<GetSpbg>(
        future: getSpbg,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.data.length + 1,
            itemBuilder: (context, i) {
              return i < snapshot.data.data.length
                  ? _buildRow(snapshot.data.data[i])
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        });
  }

  Widget _buildRow(DataSpbg data) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
        elevation: 8,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GasDetail(data: data)));
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 70,
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.location_on,
                  size: 35,
                  color: Color(0xFFFF972F),
                ),
              ),
              SizedBox(width: 15),
              Text(
                data.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: 15),
                alignment: Alignment.centerRight,
                child: Icon(Icons.keyboard_arrow_right,
                    color: Colors.black, size: 35.0),
              ))
            ],
          ),
        ));
  }
}

Future<GetSpbg> fetchPost(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  var responseGetSpbg = await http.get(UrlCons.getSpbgArea, headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  });

  return GetSpbg.fromJson(json.decode(responseGetSpbg.body));
}
