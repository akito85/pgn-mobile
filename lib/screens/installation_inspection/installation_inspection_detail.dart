import 'package:flutter/material.dart';

class InstallationInspectionDetail extends StatefulWidget {
  // InstallationInspectionDetail({this.id});
  // final String id;
  @override
  _InstallationInspectionDetailState createState() =>
      _InstallationInspectionDetailState();
}

class _InstallationInspectionDetailState
    extends State<InstallationInspectionDetail> {
  // final String id;
  // InstallationInspectionDetailState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Installation Inspection',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Batam',
                      style: TextStyle(
                          color: const Color(0xFF5C727D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Text('18 November 2021',
                      style: TextStyle(
                          color: const Color(0xFF5C727D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text('JOKO Joko',
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xFF427CEF),
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  alignment: Alignment.topLeft,
                  child: Text('Jalan swakarsa',
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF5C727D),
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Divider(color: Colors.blueGrey),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Inspection Summary',
                          style: TextStyle(
                              color: const Color(0xFF427CEF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Inspection summary description',
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Divider(color: Colors.blueGrey),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'General Visual Inspection',
                          style: TextStyle(
                              color: const Color(0xFF427CEF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF0000),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 24,
                                    height: 24,
                                    child: Image(
                                      image: AssetImage('assets/ic_water.png'),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text('Leaks',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ))),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 12,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFFF0000)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Text 1 sdadsaas',
                                style: TextStyle(
                                    color: Color(0xFFFF0000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFFF0000)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Text 1 sdadsaas',
                                style: TextStyle(
                                    color: Color(0xFFFF0000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFFF0000)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Text 1 sdadsaas',
                                style: TextStyle(
                                    color: Color(0xFFFF0000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
