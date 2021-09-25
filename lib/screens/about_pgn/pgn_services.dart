import 'dart:convert';
import 'dart:typed_data';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/product_infromation.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PgnServices extends StatefulWidget {
  @override
  PgnServicesState createState() => PgnServicesState();
}

class PgnServicesState extends State<PgnServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/background_information_product.jpg"),
                      fit: BoxFit.fill))),
          AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              title: Text(
                'PGN Products and Services' ?? '-',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              backgroundColor: Colors.transparent),
          new Positioned(
              top: 130.0,
              left: 100.0,
              right: 30.0,
              bottom: 0.0,
              child: Container(
                child: Text(
                    Translations.of(context)
                        .text('title_cover_information_product'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0)),
              )),
          _buildContant(context, fetchPost(context))
        ],
      ),
    );
  }
}

Widget _buildContant(
    BuildContext context, Future<GetProductInformation> getProduct) {
  return FutureBuilder<GetProductInformation>(
      future: getProduct,
      builder: (context, snapsnapshot) {
        if (!snapsnapshot.hasData) return LinearProgressIndicator();
        return Container(
          margin: EdgeInsets.only(top: 220),
          child: ListView.builder(
            itemCount: snapsnapshot.data.data.length + 1,
            itemBuilder: (context, i) {
              return i < snapsnapshot.data.data.length
                  ? _buildRow(snapsnapshot.data.data[i], context)
                  : SizedBox(
                      height: 10.0,
                    );
            },
          ),
        );
      });
}

Widget _buildRow(DataProduct data, BuildContext context) {
  return Container(
    child: ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    tapHeaderToExpand: true,
                    hasIcon: false,
                    tapBodyToCollapse: true,
                    collapsed: Row(
                      children: <Widget>[
                        Container(
                          height: 100,
                          margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0),
                          child: _setImage(context, data),
                        ),
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 18),
                                child: Text(
                                  data.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 5, left: 18),
                                child: Text(
                                  data.description,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.keyboard_arrow_right),
                        ))
                      ],
                    ),
                    expanded: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                height: 100,
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0),
                                child: _setImage(context, data)),
                            SizedBox(width: 18),
                            Text(data.name,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                )),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.keyboard_arrow_down),
                            ))
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                data.description,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  height: 2,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                indent: 16,
                                endIndent: 250,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(bottom: 12, left: 16),
                              child: Text(
                                Translations.of(context)
                                    .text('for_further_information' ?? "-"),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.73,
                                    height: 40.0,
                                    margin: EdgeInsets.only(
                                        left: 16.0, right: 12.0, bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Color(0xFF427CEF)),
                                    child: ElevatedButton.icon(
                                        onPressed: () async {
                                          await sendEmail(data.pic_email);
                                        },
                                        icon: Icon(Icons.email_outlined,
                                            color: Colors.white),
                                        label: Text(data.pic_email))),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      bottom: 20.0, right: 16.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.lightGreen,
                                          onPrimary: Colors.white,
                                          shadowColor: Colors.black38,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              40)),
                                      onPressed: () async {
                                        await call(data.pic_phone);
                                      },
                                      child: Image.asset(
                                          'assets/ic_phone_outline.png',
                                          width: 24.0,
                                          height: 24.0,
                                          color: Colors.white)),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 2),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          crossFadePoint: 0,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<GetProductInformation> fetchPost(BuildContext context) async {
  final sotarageCache = FlutterSecureStorage();
  String accessToken = await sotarageCache.read(key: 'access_token');
  String lang = await sotarageCache.read(key: 'lang');
  var responseGetProduct =
      await http.get('${UrlCons.mainDevUrl}products', headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
    'Accept-Language': lang
  });
  return GetProductInformation.fromJson(json.decode(responseGetProduct.body));
}

Future<void> call(String phoneNumber) async {
  return launch('tel:$phoneNumber');
}

Future<void> sendEmail(String email) async {
  return launch('mailto:$email');
}

Widget _setImage(BuildContext context, DataProduct data) {
  if (data.image != null) {
    var splitString = data.image.split(',');
    Uint8List imgs = base64.decode(splitString[1]);
    return Image.memory(
      imgs,
      width: 85.0,
      height: 65.0,
    );
  } else {
    return Image.asset(
      'assets/sinergi_image.jpeg',
      height: 65.0,
      width: 85.0,
    );
  }
}
