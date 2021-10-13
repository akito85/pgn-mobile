import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/customer_profile_residential.dart';

class MyProfileCustResidential extends StatefulWidget {
  final CustomerProfileResidentialModel data;
  MyProfileCustResidential(this.data);

  @override
  _MyProfileCustResidentialState createState() =>
      _MyProfileCustResidentialState();
}

class _MyProfileCustResidentialState extends State<MyProfileCustResidential> {
  final TextEditingController addressCtrl = new TextEditingController();
  String product = '-';
  @override
  Widget build(BuildContext context) {
    getCred(context);
    addressCtrl.text = widget.data.data.address;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/new_backgound.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 25.0, left: 20, right: 20),
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 12, color: Color(0x61000000)),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: Text(
                    widget.data.data.name,
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20, right: 20),
                child: Divider(color: Color(0x61000000)),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Text(
                    "Customer ID",
                    style: TextStyle(fontSize: 12, color: Color(0x61000000)),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: Text(
                    widget.data.data.id,
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20, right: 20),
                child: Divider(color: Color(0x61000000)),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 12, color: Color(0x61000000)),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: Text(
                    widget.data.data.address,
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20, right: 20),
                child: Divider(color: Color(0x61000000)),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Text(
                    "Product",
                    style: TextStyle(fontSize: 12, color: Color(0x61000000)),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: Text(
                    product,
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20, right: 20),
                child: Divider(color: Color(0x61000000)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getCred(context) async {
    final storageCache = FlutterSecureStorage();
    String products = await storageCache.read(key: 'products');
    setState(() {
      product = products;
    });
  }
}
