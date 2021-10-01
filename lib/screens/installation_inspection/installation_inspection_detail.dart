import 'package:flutter/material.dart';

class InstallationInspectionDetail extends StatefulWidget {
  InstallationInspectionDetail({this.id});
  final String id;
  @override
  _InstallationInspectionDetailState createState() =>
      _InstallationInspectionDetailState(id);
}

class _InstallationInspectionDetailState
    extends State<InstallationInspectionDetail> {
  final String id;
  _InstallationInspectionDetailState(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            margin: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontWeight: FontWeight.normal)),
                ),
                _buildDivider(context, 16.0),
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
                _buildDivider(context, 16.0),
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
                                  vertical: 7, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 24,
                                    height: 24,
                                    child: ImageIcon(
                                        AssetImage('assets/ic_water.png'),
                                        color: Colors.white,
                                        size: 25),
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
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12, left: 16),
                        child: Row(
                          children: <Widget>[
                            Text("Notes      ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                            'Vestibulum in commodo massa, nec congue dolor. Etiam a viverra dolor, venenatis fringilla orci. Fusce vitae lectus erat. Sed in metus et quam posuere finibus.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                height: 2,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                  AssetImage('assets/ic_misalignment.png'),
                                  color: Colors.black,
                                  size: 24)),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'Misalignment',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                _buildDescription(context, ""),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 24,
                              height: 24,
                              child: Icon(Icons.waves_outlined,
                                  color: Colors.black, size: 24)),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'Vibration',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                _buildDescription(context, ""),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                  AssetImage('assets/ic_support.png'),
                                  color: Colors.black,
                                  size: 24)),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'Support',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                _buildDescription(context, ""),
                Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFFF0000),
                        borderRadius: BorderRadius.circular(3)),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                  AssetImage('assets/ic_corrosion.png'),
                                  color: Colors.white,
                                  size: 24),
                            ),
                            SizedBox(width: 8),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text('External Corrosion',
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 16),
                  child: Row(
                    children: <Widget>[
                      Text("Notes      ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14)),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, left: 16),
                  child: Text(
                      'Vestibulum in commodo massa, nec congue dolor. Etiam a viverra dolor, venenatis fringilla orci. Fusce vitae lectus erat. Sed in metus et quam posuere finibus.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 2,
                          fontWeight: FontWeight.normal)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 27),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                  AssetImage('assets/ic_insulation.png'),
                                  color: Colors.black,
                                  size: 24)),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'Insulation',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                _buildDescription(context, ""),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 8),
                              width: 24,
                              height: 24,
                              child: ImageIcon(
                                  AssetImage('assets/ic_asteriks.png'),
                                  color: Colors.black,
                                  size: 24)),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              'Other',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                ),
                _buildDescription(context, ""),
                _buildDivider(context, 0.0),
                SizedBox(height: 20),
                _buildBottomBoxContainer(
                    context,
                    'assets/ic_list.png',
                    'Inspected by:',
                    'PT Solusi Energi Nusantara',
                    'Inspector:',
                    'Ipung Susanto',
                    'Date:',
                    '18 November 2021'),
                SizedBox(height: 8),
                _buildBottomBoxContainer(
                    context,
                    'assets/ic_checkmark.png',
                    'Acknowledged by:',
                    'PT Solusi Energi Nusantara',
                    'Engineer:',
                    'Ipung Susanto',
                    'Date:',
                    '18 November 2021'),
                SizedBox(height: 20),
                _buildBottomBoxOutlined(context, 'Inspection Remark: FAILED')
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _buildDescription(BuildContext context, String desc) {
  if (desc != "") {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(desc,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.normal)),
    );
  } else {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text('No issues recorded',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: const Color(0xFFADADAD),
              fontSize: 14,
              fontWeight: FontWeight.normal)),
    );
  }
}

Widget _buildDivider(BuildContext context, double margin) {
  return Container(
    margin: EdgeInsets.only(top: margin),
    child: Divider(color: const Color(0xFFF4F4F4)),
  );
}

Widget _buildBottomBoxContainer(BuildContext context, String icon, String title,
    String descTitle, String type, String name, String titleDate, String date) {
  return Container(
    decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(2)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child:
                    ImageIcon(AssetImage(icon), color: Colors.black, size: 40),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  SizedBox(height: 4),
                  Text(descTitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))
                ],
              )
            ],
          ),
          SizedBox(height: 12),
          Text(type + "        " + name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14)),
          SizedBox(height: 4),
          type == "Inspector:"
              ? Text(titleDate + "                " + date,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14))
              : Text(titleDate + "               " + date,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14))
        ],
      ),
    ),
  );
}

Widget _buildBottomBoxOutlined(BuildContext context, String title) {
  return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: const Color(0xFFFF0000)),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFFFF0000),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )));
}
