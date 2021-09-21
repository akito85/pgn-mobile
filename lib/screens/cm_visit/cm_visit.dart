import 'package:flutter/material.dart';
import 'package:pgn_mobile/screens/cm_visit/cm_visit_detail.dart';

class CMVisit extends StatefulWidget {
  @override
  _CMVisitState createState() => _CMVisitState();
}

class _CMVisitState extends State<CMVisit> with TickerProviderStateMixin {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              bottom: 10,
              left: 18,
              right: 18,
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF427CEF)),
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CMVisitDetail()));
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add New Visit Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal))),
              ))
        ],
      ),
    );
  }
}
