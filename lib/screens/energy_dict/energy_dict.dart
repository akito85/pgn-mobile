import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

import 'package:pgn_mobile/models/vocabularies_model.dart';
import 'package:pgn_mobile/screens/energy_dict/widgets/energy_dict_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnergyDict extends StatefulWidget {
  @override
  EnergyDictState createState() => EnergyDictState();
}

class EnergyDictState extends State<EnergyDict> {
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    fetchPost(context);
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('a_home_tv_menu_dictionary'),
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

  Widget _buildContent(BuildContext context, Future<GetVocabularies> getSpbg) {
    return FutureBuilder<GetVocabularies>(
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
      },
    );
  }

  Widget _buildRow(DataVocabularies data) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VocabulariesDetail(data: data)));
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 12.0, 0.0, 12),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF4578EF),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0),
                  child: Text(
                    data.title,
                    style: TextStyle(
                        color: Color(0xFF4578EF), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<GetVocabularies> fetchPost(BuildContext context) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetVocabularies =
      await http.get('${UrlCons.mainProdUrl}vocabularies', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });

  return GetVocabularies.fromJson(json.decode(responseGetVocabularies.body));
}
