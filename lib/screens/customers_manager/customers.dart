import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pgn_mobile/models/cust_list_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:pgn_mobile/screens/customers_manager/widgets/customer_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';

class Customers extends StatefulWidget {
  @override
  CustomerState createState() => CustomerState();
}

class CustomerState extends State<Customers> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  List<DataListCust> returnGetDataListCust = [];
  var items = List<DataListCust>();
  int lengthList;
  bool _loading = false;
  final listData = List<DataListCust>();

  Icon actionIcon = new Icon(Icons.search, color: Colors.white);
  Widget appBarTitle = new Text(
    "Customers",
    style: TextStyle(color: Colors.white),
  );
  String nextPage = "";
  String errorStat = "";

  @override
  void initState() {
    items.addAll(listData);
    super.initState();

    if (nextPage == "") {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          this.fetchPostNextPage(context, "");
        }
      });
    }
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 45,
                margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _searchQuery,
                    decoration: InputDecoration(
                      labelText: 'Keyword',
                      labelStyle: TextStyle(
                          color: Color(0xff427CEF),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFF427CEF),
                        ),
                        onPressed: () {
                          if (_searchQuery.text.isNotEmpty) {
                            fetchPost(context, _searchQuery.text);
                            runLoading();
                          } else {
                            fetchPost(context, "");
                            runLoading();
                          }
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        _buildContent(context, fetchPost(context, ""))
      ],
    );
  }

  Widget _buildContent(
      BuildContext context, Future<CustListModel> getCustList) {
    return FutureBuilder<CustListModel>(
      future: getCustList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (errorStat != "")
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  errorStat,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: returnGetDataListCust.length + 1,
          itemBuilder: (context, i) {
            return i < returnGetDataListCust.length
                ? _buildRow(returnGetDataListCust[i])
                : _loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      );
          },
        );
      },
    );
  }

  void runLoading() {
    setState(() {
      _loading = true;
    });
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _loading = false;
      });
    });
  }

  Widget _buildRow(DataListCust data) {
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
                  builder: (context) => CustomersDetail(data: data)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/icon_default_pelanggan.png'),
                ),
                SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 260,
                      margin: EdgeInsets.only(top: 11),
                      child: Text(data.name ?? '',
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
                )
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

  Future<CustListModel> fetchPost(
      BuildContext context, String searchKey) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetCustList = await http
        .get('${UrlCons.mainProdUrl}customers?q=$searchKey', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });

    CustListModel returnGetListCust =
        CustListModel.fromJson(json.decode(responseGetCustList.body));
    if (nextPage == "") {
      setState(() {
        returnGetDataListCust.clear();
        returnGetDataListCust.addAll(returnGetListCust.data);
        lengthList = returnGetDataListCust.length;
        nextPage = returnGetListCust.paging.next;
      });
    } else if (nextPage != "" && searchKey != "") {
      if (returnGetListCust.data != null) {
        setState(() {
          returnGetDataListCust.clear();
          returnGetDataListCust.addAll(returnGetListCust.data);
          lengthList = returnGetDataListCust.length;
        });
      }
    }

    return CustListModel.fromJson(json.decode(responseGetCustList.body));
  }

  Future<CustListModel> fetchPostNextPage(
      BuildContext context, String searchKey) async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetCustList = await http
        .get('${UrlCons.mainProdUrl}customers?cursor=$nextPage', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang
    });

    CustListModel returnGetListCust =
        CustListModel.fromJson(json.decode(responseGetCustList.body));

    if (nextPage != returnGetListCust.paging.next) {
      setState(() {
        returnGetDataListCust.clear();
        returnGetDataListCust.addAll(returnGetListCust.data);
        lengthList = returnGetDataListCust.length;
        nextPage = returnGetListCust.paging.next;
      });
    }

    return CustListModel.fromJson(json.decode(responseGetCustList.body));
  }
}
