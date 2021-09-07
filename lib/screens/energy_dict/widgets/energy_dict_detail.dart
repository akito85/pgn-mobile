import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/models/vocabularies_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VocabulariesDetail extends StatefulWidget {
  VocabulariesDetail({this.data});
  final DataVocabularies data;
  @override
  VocabulariesDetailState createState() => VocabulariesDetailState(data);
}

class VocabulariesDetailState extends State<VocabulariesDetail> {
  DataVocabularies data;
  VocabulariesDetailState(this.data);

  @override
  Widget build(BuildContext context) {
    fetchPost(context, data.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          ListView(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _buildContent(context, fetchPost(context, data.id)),
            Divider()
          ]),
        ],
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<GetVocabularieDetail> getVocabulariDetail) {
    return FutureBuilder<GetVocabularieDetail>(
        future: getVocabulariDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _content(context, snapshot.data.data);
        });
  }

  Widget _content(BuildContext context, DataVocabularieDetail data) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(data.imageUrl),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 15.0),
            child: Text(
              data.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Text(
              data.description,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

Future<GetVocabularieDetail> fetchPost(BuildContext context, String id) async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String accessToken = prefs.getString('access_token');
  // String lang = prefs.getString('lang');
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetVocabularieDetail =
      await http.get('${UrlCons.mainProdUrl}vocabularies/$id', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });

  return GetVocabularieDetail.fromJson(
      json.decode(responseGetVocabularieDetail.body));
}
