import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/notification_customer_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/notification_customer/widgets/notification_customer_detail.dart';

class NotificationCustomer extends StatefulWidget {
  @override
  NotificationCustomerState createState() => NotificationCustomerState();
}

class NotificationCustomerState extends State<NotificationCustomer> {
  List<DataNotifList> listDataNotif = [];
  List<dynamic> nextPage = [];
  String errorStat = "";
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        isLoading = true;

        this.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Inbox',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContent(context, fetchPost(context)),
            isLoading == true ? CircularProgressIndicator : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<NotifCustModel> getListNotif) {
    return FutureBuilder<NotifCustModel>(
        future: getListNotif,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 180),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listDataNotif.length + 1,
              itemBuilder: (context, i) {
                return i < listDataNotif.length
                    ? _buildRow(listDataNotif[i])
                    : SizedBox(
                        height: 10.0,
                      );
              });
        });
  }

  Widget _buildRow(DataNotifList data) {
    return Column(
      children: <Widget>[Card1(data)],
    );
  }

  void loadMore() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var body = json.encode({
      "except": nextPage,
    });
    var response = await http.post(
      '${UrlCons.mainProdUrl}customers/me/notification-inbox',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
      body: body,
    );

    NotifCustModel notifCustModel =
        NotifCustModel.fromJson(json.decode(response.body));
    if (notifCustModel.message != null && notifCustModel.data.length == 0) {
      setState(() {
        errorStat = notifCustModel.message;
        isLoading = false;
      });
    } else if (notifCustModel.data != null) {
      setState(() {
        nextPage = notifCustModel.paging;
        listDataNotif.addAll(notifCustModel.data);
        isLoading = false;
      });
    }
  }
}

Future<NotifCustModel> fetchPost(BuildContext context) async {
  final storageCache = FlutterSecureStorage();
  String accessToken = await storageCache.read(key: 'access_token');
  String lang = await storageCache.read(key: 'lang');
  var response = await http.post(
    '${UrlCons.mainProdUrl}customers/me/notification-inbox',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    },
  );
  NotifCustModel notifCustModel =
      NotifCustModel.fromJson(json.decode(response.body));

  return notifCustModel;
}

class Card1 extends StatelessWidget {
  final DataNotifList data;
  Card1(this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotifCustDetail(id: data.id),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.payload.type == 'notifikasi_progress_berlangganan')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                      ),
                    ),
                  if (data.payload.type == 'Info Perubahan Ketentuan')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF427CEF),
                      ),
                    ),
                  if (data.payload.type == 'Info Pembayaran Pelanggan')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                      ),
                    ),
                  if (data.payload.type == 'Info Tagihan')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF427CEF),
                      ),
                    ),
                  if (data.payload.type ==
                      'Data tagihan terbaru sudah tersedia')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF427CEF),
                      ),
                    ),
                  if (data.payload.type ==
                      'Konfirmasi Pengajuan Technical Complaint')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                      ),
                    ),
                  if (data.payload.type ==
                      'Konfirmasi Pengajuan Komerisal Dan Keuangan')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                      ),
                    ),
                  if (data.payload.type == 'Info Penutupan Aliran')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                      ),
                    ),
                  if (data.payload.type == 'Promosi')
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF427CEF),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10, right: 15),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${data.payload.type}',
                        style:
                            TextStyle(color: Color(0xFFADADAD), fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 15),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('dd MMM yyy').format(
                              DateTime.parse(data.date.toString()).toLocal()),
                          style: TextStyle(
                              color: Color(0xFF5C727D),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('hh:mm:ss a').format(
                              DateTime.parse(data.date.toString()).toLocal()),
                          style: TextStyle(
                              color: Color(0xFF5C727D),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 60, top: 10, right: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${data.payload.title}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                      color: Color(0xFF5C727D),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, top: 10, right: 15),
                child: Divider(),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 60, top: 10, right: 15, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${data.payload.body}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(color: Color(0xFF5C727D), fontSize: 14),
                ),
              ),
              data.payload.imageUrl != null
                  ? Container(
                      margin: EdgeInsets.only(left: 60, bottom: 20),
                      alignment: Alignment.centerLeft,
                      child: Image.network(
                        data.payload.imageUrl,
                      ),
                    )
                  : SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
