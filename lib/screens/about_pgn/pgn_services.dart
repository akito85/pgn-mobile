import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pgn_mobile/services/app_localizations.dart';

class PgnServices extends StatefulWidget {
  @override
  PgnServicesState createState() => PgnServicesState();
}

class PgnServicesState extends State<PgnServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/background_information_product.jpg"),
                      fit: BoxFit.fill))),
          AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              title: Text(
                'PGN Products and Services' ?? '-',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              backgroundColor: Colors.transparent),
          Positioned(
              top: 130.0,
              left: 100.0,
              right: 30.0,
              bottom: 0.0,
              child: Container(
                child: Text(
                    Translations.of(context)
                        .text('title_cover_information_product'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0)),
              )),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(top: 200),
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      scrollOnExpand: false,
                      scrollOnCollapse: true,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 5),
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                  tapHeaderToExpand: true,
                                  hasIcon: false,
                                  tapBodyToCollapse: true,
                                  collapsed: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 0.0, 0.0, 0),
                                        child: Image.asset(
                                          'assets/sinergi_image.jpeg',
                                          height: 60.0,
                                          width: 80.0,
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              child: Text(
                                                "Sinergi Bronz 3 aaa",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              child: Text(
                                                "Untuk bisnis rumahan dan ruko serta lorem ipsum",
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.keyboard_arrow_right),
                                      ))
                                    ],
                                  ),
                                  expanded: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 70,
                                            margin: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0),
                                            child: Image.asset(
                                              'assets/sinergi_image.jpeg',
                                              height: 60.0,
                                              width: 80.0,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text('Sinergi Bronz 3 aaa',
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Fusce iaculis purus aliquam, egestas nisi sit amet, imperdiet arcu. Praesent nisl libero, dapibus sit amet mattis et, eleifend sed ex. Quisque euismod nisl at dui suscipit dapibus. Etiam non nisi congue ex aliquam vehicula. Nam eros eros, placerat sed metus vitae, mollis tincidunt mi. Vestibulum eu ipsum a sem cursus gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque eleifend sollicitudin. Vestibulum tristique euismod neque, non mattis erat ornare vitae nunc.',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                height: 2,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Divider(
                                              indent: 16,
                                              endIndent: 250,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(
                                                bottom: 12, left: 16),
                                            child: Text(
                                              'For further information',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: 222.0,
                                                  height: 40.0,
                                                  margin: EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 12.0,
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Color(0xFF427CEF)),
                                                  child: ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.email_outlined,
                                                          color: Colors.white),
                                                      label: Text(
                                                          'info@pgn.co.id'))),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    bottom: 20.0, right: 16.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.lightGreen,
                                                        onPrimary: Colors.white,
                                                        shadowColor:
                                                            Colors.black38,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        minimumSize:
                                                            Size(84, 40)),
                                                    onPressed: () {},
                                                    child: Image.asset(
                                                        'assets/ic_phone_outline.png',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        color: Colors.white)
                                                  ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, bottom: 2),
                                      child: Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        crossFadePoint: 0,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      scrollOnExpand: false,
                      scrollOnCollapse: true,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 5),
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                  tapHeaderToExpand: true,
                                  hasIcon: false,
                                  tapBodyToCollapse: true,
                                  collapsed: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 0.0, 0.0, 0),
                                        child: Image.asset(
                                          'assets/sinergi_image.jpeg',
                                          height: 60.0,
                                          width: 80.0,
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              child: Text(
                                                "Sinergi Bronz 3 aaa",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              child: Text(
                                                "Untuk bisnis rumahan dan ruko serta lorem ipsum",
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.keyboard_arrow_right),
                                      ))
                                    ],
                                  ),
                                  expanded: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 70,
                                            margin: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0),
                                            child: Image.asset(
                                              'assets/sinergi_image.jpeg',
                                              height: 60.0,
                                              width: 80.0,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text('Sinergi Bronz 3 aaa',
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Fusce iaculis purus aliquam, egestas nisi sit amet, imperdiet arcu. Praesent nisl libero, dapibus sit amet mattis et, eleifend sed ex. Quisque euismod nisl at dui suscipit dapibus. Etiam non nisi congue ex aliquam vehicula. Nam eros eros, placerat sed metus vitae, mollis tincidunt mi. Vestibulum eu ipsum a sem cursus gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque eleifend sollicitudin. Vestibulum tristique euismod neque, non mattis erat ornare vitae nunc.',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                height: 2,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Divider(
                                              indent: 16,
                                              endIndent: 250,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(
                                                bottom: 12, left: 16),
                                            child: Text(
                                              'For further information',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: 222.0,
                                                  height: 40.0,
                                                  margin: EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 12.0,
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Color(0xFF427CEF)),
                                                  child: ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.email_outlined,
                                                          color: Colors.white),
                                                      label: Text(
                                                          'info@pgn.co.id'))),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    bottom: 20.0, right: 16.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.lightGreen,
                                                        onPrimary: Colors.white,
                                                        shadowColor:
                                                            Colors.black38,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        minimumSize:
                                                            Size(84, 40)),
                                                    onPressed: () {},
                                                    child: Image.asset(
                                                        'assets/ic_phone_outline.png',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        color: Colors.white)
                                                  ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, bottom: 2),
                                      child: Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        crossFadePoint: 0,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      scrollOnExpand: false,
                      scrollOnCollapse: true,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 5),
                          elevation: 8,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                  tapHeaderToExpand: true,
                                  hasIcon: false,
                                  tapBodyToCollapse: true,
                                  collapsed: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 0.0, 0.0, 0),
                                        child: Image.asset(
                                          'assets/sinergi_image.jpeg',
                                          height: 60.0,
                                          width: 80.0,
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 12),
                                              child: Text(
                                                "Sinergi Bronz 3 aaa",
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, left: 12),
                                              child: Text(
                                                "Untuk bisnis rumahan dan ruko serta lorem ipsum",
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.keyboard_arrow_right),
                                      ))
                                    ],
                                  ),
                                  expanded: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            height: 70,
                                            margin: EdgeInsets.fromLTRB(
                                                15.0, 0.0, 0.0, 0),
                                            child: Image.asset(
                                              'assets/sinergi_image.jpeg',
                                              height: 60.0,
                                              width: 80.0,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text('Sinergi Bronz 3 aaa',
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              )),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Fusce iaculis purus aliquam, egestas nisi sit amet, imperdiet arcu. Praesent nisl libero, dapibus sit amet mattis et, eleifend sed ex. Quisque euismod nisl at dui suscipit dapibus. Etiam non nisi congue ex aliquam vehicula. Nam eros eros, placerat sed metus vitae, mollis tincidunt mi. Vestibulum eu ipsum a sem cursus gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque eleifend sollicitudin. Vestibulum tristique euismod neque, non mattis erat ornare vitae nunc.',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                                height: 2,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Divider(
                                              indent: 16,
                                              endIndent: 250,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(
                                                bottom: 12, left: 16),
                                            child: Text(
                                              'For further information',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  width: 222.0,
                                                  height: 40.0,
                                                  margin: EdgeInsets.only(
                                                      left: 16.0,
                                                      right: 12.0,
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Color(0xFF427CEF)),
                                                  child: ElevatedButton.icon(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.email_outlined,
                                                          color: Colors.white),
                                                      label: Text(
                                                          'info@pgn.co.id'))),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    bottom: 20.0, right: 16.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.lightGreen,
                                                        onPrimary: Colors.white,
                                                        shadowColor:
                                                            Colors.black38,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        minimumSize:
                                                            Size(84, 40)),
                                                    onPressed: () {},
                                                    child: Image.asset(
                                                        'assets/ic_phone_outline.png',
                                                        width: 24.0,
                                                        height: 24.0,
                                                        color: Colors.white)
                                                  ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: 10, bottom: 2),
                                      child: Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        crossFadePoint: 0,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
