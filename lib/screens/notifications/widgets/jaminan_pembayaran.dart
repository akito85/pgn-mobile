import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/notification_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/notifications/widgets/j_pembayaran_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

class JaminanPembayaran extends StatefulWidget {
  @override
  JamPembayaranState createState() => JamPembayaranState();
}

class JamPembayaranState extends State<JaminanPembayaran> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  String nextPage = "";
  String errorStat = "";
  List<DataNotifList> returnGetNotifGuarantee = [];
  @override
  void initState() {
    this.fetchPostNextPage(context);
    super.initState();
    _scrollController.addListener(() {
      if (nextPage != null) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          this.fetchPostNextPage(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (errorStat != "")
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/penggunaan_gas.png'),
          ),
          SizedBox(height: 20),
          Container(
            child: Text(
              errorStat,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 40),
        ],
      );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: returnGetNotifGuarantee.length + 1,
      controller: _scrollController,
      itemBuilder: (context, i) {
        if (i == returnGetNotifGuarantee.length) {
          return _buildProgressIndicator();
        } else {
          return i < returnGetNotifGuarantee.length
              ? _buildRow(returnGetNotifGuarantee[i])
              : SizedBox(
                  height: 10.0,
                );
        }
      },
    );
  }

  // Widget _buildContent(
  //     BuildContext context, Future<GetNotificationList> getSpbg) {
  //   return FutureBuilder<GetNotificationList>(
  //     future: getSpbg,
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return LinearProgressIndicator();
  //       if (snapshot.data.message != null)
  //         return Column(
  //           children: <Widget>[
  //             SizedBox(height: 150),
  //             Container(
  //               alignment: Alignment.center,
  //               child: Image.asset('assets/penggunaan_gas.png'),
  //             ),
  //             SizedBox(height: 20),
  //             Container(
  //               child: Text(
  //                 snapshot.data.message,
  //                 style: TextStyle(fontSize: 18),
  //               ),
  //             )
  //           ],
  //         );
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: returnGetNotifGuarantee.length,
  //         itemBuilder: (context, i) {
  //           return i < returnGetNotifGuarantee.length
  //               ? _buildRow(returnGetNotifGuarantee[i])
  //               : Center(
  //                   child: Padding(
  //                     padding: EdgeInsets.only(bottom: 20.0),
  //                     child: CircularProgressIndicator(),
  //                   ),
  //                 );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _buildRow(DataNotifList data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JamPembayaranDetail(data: data)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (data.imageUrl == null)
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/icon_default_pelanggan.png'),
                  ),
                if (data.imageUrl != null)
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(data.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // width: 260,
                        margin: EdgeInsets.only(top: 11, right: 10),
                        child: Text(data.nameCust ?? '',
                            style: TextStyle(
                                color: Colors.blue[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0)),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 14, top: 3),
                          child: Text(
                            'CM - ${data.aeId} | ${data.id}',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 13, left: 18, bottom: 18, right: 18),
              child: Text(
                data.address ?? '-',
                style: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchPostNextPage(BuildContext context) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    var responseGetSpbg = await http.get(
        '${UrlCons.mainProdUrl}customers?issue=guarantee&limit=10&cursor=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        });
    GetNotificationList returnGetNotifGuarantees =
        GetNotificationList.fromJson(json.decode(responseGetSpbg.body));

    if (returnGetNotifGuarantees.message != null &&
        returnGetNotifGuarantee.length == 0) {
      setState(() {
        errorStat = returnGetNotifGuarantees.message;
      });
    } else if (returnGetNotifGuarantees.data != null) {
      setState(() {
        nextPage = returnGetNotifGuarantees.paging.next;
        returnGetNotifGuarantee.addAll(returnGetNotifGuarantees.data);
      });
    }
  }
}
