import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/customer_profile_residential.dart';

class MyProfileCustResidential extends StatelessWidget {
  final CustomerProfileResidentialModel data;
  MyProfileCustResidential(this.data);

  final TextEditingController addressCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    addressCtrl.text = data.data.address;
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
                    data.data.name,
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
                    data.data.id,
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
                    data.data.address,
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
}
