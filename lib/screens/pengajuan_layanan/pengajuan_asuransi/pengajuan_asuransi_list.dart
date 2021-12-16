import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pgn_mobile/models/pengajuan_asuransi_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_asuransi/pengajuan_asuransi_detail.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_asuransi/pengajuan_asuransi_form.dart';

class PengajuanAsuransiList extends StatefulWidget {
  @override
  _PengajuanAsuransiListState createState() => _PengajuanAsuransiListState();
}

class _PengajuanAsuransiListState extends State<PengajuanAsuransiList> {
  String userName = '';
  String userID = '';
  String nextPage = '';
  bool _isLoading = false;
  List<Datas> datas = [];
  ScrollController _scrollController = ScrollController();
  final storageCache = FlutterSecureStorage();

  void initState() {
    super.initState();

    this.loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        this.loadMore();

        Future.delayed(Duration(seconds: 3), _updateStatus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _updateStatus() async {
    setState(() {
      _isLoading = false;
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
          'Pengajuan Asuransi Kebakaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              FutureBuilder<PengajuanAsuransiModel>(
                future: getFuturePengajuanAsuransiList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 18, right: 18, top: 5),
                      child: LinearProgressIndicator(),
                    );
                  if (snapshot.data.code != null)
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 150),
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
                    itemCount: datas.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PengajuanKembaliDetail(id: datas[i].id),
                            ),
                          ).then((value) => setState(() {
                                datas.clear();
                                nextPage = '';
                                loadMore();
                              }));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          margin: EdgeInsets.only(top: 10, left: 18, right: 18),
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 17, top: 10, right: 14),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${datas[i].status}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF427CEF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 17),
                                    child: Text(
                                      DateFormat('dd MMM yyy | hh:mm:ss a')
                                          .format(
                                              DateTime.parse(datas[i].createdAt)
                                                  .toLocal()),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 10),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text('ID Pelanggan'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 10,
                                      child: Text(':'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text('${datas[i].idCust}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text('Nama Pelanggan'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 10,
                                      child: Text(':'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text('${datas[i].name}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text('Tanggal Pengaliran'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 10,
                                      child: Text(':'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text(
                                            '${DateFormat('dd MMMM yyy ').format(DateTime.parse(datas[i].subDate).toLocal())}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 10, bottom: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text('Liability yang Diajukan'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 10,
                                      child: Text(':'),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text('${datas[i].subLia}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 90),
            ],
          ),
          Positioned(
            bottom: 15,
            left: 18,
            right: 18,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '   Tambah Pengajuan',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PengajuanAsuransiForm(),
                    ),
                  ).then((value) => setState(() {
                        datas.clear();
                        nextPage = '';
                        loadMore();
                      }));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void loadMore() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProg = await http.get(
        '${UrlCons.mainDevUrl}customer-service/fire-insurance-application?per_page=10&next_page=$nextPage',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    PengajuanAsuransiModel returnData =
        PengajuanAsuransiModel.fromJson(json.decode(responseGetSubsProg.body));

    if (returnData.message == null && returnData.data.length > 0) {
      setState(() {
        nextPage = returnData.nextPage;
        datas.addAll(returnData.data);
      });
    }
  }

  Future<PengajuanAsuransiModel> getFuturePengajuanAsuransiList() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var response = await http.get(
        '${UrlCons.mainDevUrl}customer-service/fire-insurance-application?per_page=10',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': lang,
        });
    print('GET LIST PENGAJUAN ASURANSI ${response.body}');
    return PengajuanAsuransiModel.fromJson(json.decode(response.body));
  }
}
