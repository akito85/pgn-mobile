import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pgn_mobile/models/subscription_progress_model.dart';
import 'package:pgn_mobile/models/url_cons.dart';
import 'package:http/http.dart' as http;
import 'package:pgn_mobile/screens/otp/otp.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProgressSubscriptions extends StatefulWidget {
  @override
  _ProgressSubscriptionsState createState() => _ProgressSubscriptionsState();
}

class _ProgressSubscriptionsState extends State<ProgressSubscriptions> {
  ScrollController _scrollController = ScrollController();
  List<DataSubscription> returnSubsProg = [];
  String userName = '';
  String userID = '';
  String nextPage = '';
  TextEditingController formIDCtrl = TextEditingController();
  TextEditingController ktpIDCtrl = TextEditingController();
  final storageCache = FlutterSecureStorage();
  void initState() {
    super.initState();

    getDataCred();
    this.getSubsProg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('pb_tab_title'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Card(
                margin:
                    EdgeInsets.only(left: 18, right: 18, bottom: 11, top: 20),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icon_default_pelanggan.png'),
                          backgroundColor: Colors.transparent,
                          radius: 21.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userName,
                            style: TextStyle(
                                color: Colors.blue[300],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          Text(
                            userID,
                            style: TextStyle(
                                color: Colors.blue[300],
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<SubscriptionsProgressModel>(
                future: getFutureSubsProg(),
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
                    itemCount: returnSubsProg.length,
                    itemBuilder: (context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.only(top: 10, left: 18, right: 18),
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, top: 11, right: 14),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Form ID : ${returnSubsProg[i].formId}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: FaIcon(Icons.delete),
                                    onPressed: () {
                                      deleteFormIdAlert(
                                          returnSubsProg[i].id,
                                          returnSubsProg[i].formId,
                                          returnSubsProg[i].name);
                                    }),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Status: ${returnSubsProg[i].status}' ?? '-',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF5C727D),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 105,
                                  margin: EdgeInsets.only(left: 20.0, top: 15),
                                  child: Text(
                                    'Name Customer',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 35.0, top: 15),
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5.0, top: 15),
                                    child: Text(
                                      returnSubsProg[i].name ?? "-",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 105,
                                  margin: EdgeInsets.only(left: 20.0, top: 15),
                                  child: Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 35.0, top: 15),
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5.0, top: 15),
                                    child: Text(
                                      returnSubsProg[i].address ?? "-",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 105,
                                  margin: EdgeInsets.only(
                                      left: 20.0, top: 15, bottom: 15),
                                  child: Text(
                                    'Program',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 35.0, top: 15, bottom: 15),
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5.0, top: 15, bottom: 15),
                                    child: Text(
                                      returnSubsProg[i].program ?? "-",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 70),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 18,
            right: 18,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Color(0xFF427CEF),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  'Add Subsription Progress',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  addFormIdAlert();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void getSubsProg() async {
    final storageCache = FlutterSecureStorage();
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProg = await http
        .get('${UrlCons.mainDevUrl}prospective_customer_progress', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });
    SubscriptionsProgressModel returnGetSubsProg =
        SubscriptionsProgressModel.fromJson(
            json.decode(responseGetSubsProg.body));

    if (returnGetSubsProg.message == null &&
        returnGetSubsProg.dataSubscription.length > 0) {
      setState(() {
        nextPage = returnGetSubsProg.paging.next;
        returnSubsProg.addAll(returnGetSubsProg.dataSubscription);
      });
    }
  }

  void getDataCred() async {
    String userNameString = await storageCache.read(key: 'user_id');
    String userIDString = await storageCache.read(key: 'user_name');
    setState(() {
      userID = userNameString;
      userName = userIDString;
    });
  }

  Future<SubscriptionsProgressModel> getFutureSubsProg() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseGetSubsProg = await http
        .get('${UrlCons.mainDevUrl}prospective_customer_progress', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept-Language': lang,
    });
    return SubscriptionsProgressModel.fromJson(
        json.decode(responseGetSubsProg.body));
  }

  void deleteFormId(int reqID, String custId, String custName) async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var responseDeleteCustId = await http.delete(
      '${UrlCons.mainProdUrl}delete_prospective_customer_progress/$reqID',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': lang
      },
    );
    DeleteFormId switchCustomerId =
        DeleteFormId.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      Navigator.pop(context);
      showToast(switchCustomerId.dataDeleteCustomerId.message);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  void addFormId() async {
    String accessToken = await storageCache.read(key: 'access_token');
    String lang = await storageCache.read(key: 'lang');
    var body = json
        .encode({"form_id": formIDCtrl.text, "idcard_number": ktpIDCtrl.text});
    var responseDeleteCustId = await http.post(
        '${UrlCons.mainProdUrl}insert_prospective_customer_progress',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: body);
    print('STATUS BERLANGGANAN : ${responseDeleteCustId.body}');
    DeleteFormId switchCustomerId =
        DeleteFormId.fromJson(json.decode(responseDeleteCustId.body));
    if (responseDeleteCustId.statusCode == 200) {
      showToast(switchCustomerId.dataDeleteCustomerId.message);
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
    } else {
      showToast(switchCustomerId.message);
    }
  }

  Future<bool> deleteFormIdAlert(
      int reqIDCust, String formId, String custName) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Information !",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "${Translations.of(context).text('f_dialog_confirmation_delete_form')} $formId ($custName)",
            style: TextStyle(
                // color: painting.Color.fromRGBO(255, 255, 255, 0),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            deleteFormId(reqIDCust, formId, custName);
          },
          color: Colors.red,
          child: Text(
            "Delete",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }

  Future<bool> addFormIdAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );
    return Alert(
      context: context,
      style: alertStyle,
      title: "Add Form ID",
      content: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "${Translations.of(context).text('f_dialog_confirmation_add_form')} ",
            style: TextStyle(
                // color: painting.Color.fromRGBO(255, 255, 255, 0),
                fontSize: 17,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: TextFormField(
              controller: formIDCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Form ID',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: TextFormField(
              controller: ktpIDCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Last 6 digit of KTP',
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
      buttons: [
        DialogButton(
          width: 130,
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Colors.green,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DialogButton(
          width: 130,
          onPressed: () async {
            addFormId();
          },
          color: Colors.green,
          child: Text(
            "Add",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ).show();
  }
}