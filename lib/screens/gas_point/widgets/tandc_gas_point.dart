import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/gas_point_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;

class TandCGasPoint extends StatelessWidget {
  @override
  Widget build(context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18, top: 20, bottom: 7),
          child: Text(
            'PGN Rewards Terms and Conditions',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF4578EF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 18, right: 350, bottom: 15),
          child: Divider(
            color: Color(0xFF4578EF),
            thickness: 4,
          ),
        ),
        FutureBuilder<TandCModel>(
          future: getTandC(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: LinearProgressIndicator(),
              );
            if (snapshot.hasError)
              return Container(
                child: Text(snapshot.error),
              );
            if (snapshot.data.message != null)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    child: Image.asset('assets/penggunaan_gas.png'),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      snapshot.data.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              );
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.dataTandC.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${i + 1}.'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 10),
                          child: Text(
                            snapshot.data.dataTandC[i].content,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                wordSpacing: 0.5,
                                letterSpacing: 0.25),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

Future<TandCModel> getTandC(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var responseGetTandCGasPoint =
      await http.get('${UrlCons.mainDevUrl}terms_and_conditions', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang,
  });

  if (responseGetTandCGasPoint.statusCode == 200) {
    return TandCModel.fromJson(json.decode(responseGetTandCGasPoint.body));
  } else {
    throw Exception('Could not get any response');
  }
}
