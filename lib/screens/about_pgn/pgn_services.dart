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
                      image: AssetImage("assets/new_backgound.jpeg"),
                      fit: BoxFit.fill))),
          AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              title: Text(
                'PGN Products and Services' ?? '-',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
              backgroundColor: Colors.transparent),
          Positioned(
              top: 130.0,
              left: 100.0,
              right: 30.0,
              bottom: 0.0,
              child: Container(
                child: Text(
                    'Top of the line products and services for your every needs!',
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
                                          'assets/ic_about2.png',
                                          height: 50.0,
                                          width: 50.0,
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
                                              'assets/ic_about2.png',
                                              height: 50.0,
                                              width: 50.0,
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
                                                    child: Icon(
                                                        Icons
                                                            .phone_in_talk_outlined,
                                                        color: Colors.white)),
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
                                        height: 70,
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 0.0, 0.0, 0),
                                        child: Image.asset(
                                          'assets/ic_about2.png',
                                          height: 50.0,
                                          width: 50.0,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        Translations.of(context)
                                            .text('about_our_cust_title'),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
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
                                            // decoration: new BoxDecoration(
                                            //   color: Color(0xFF4578EF),
                                            //   shape: BoxShape.circle,
                                            // ),
                                            child: Image.asset(
                                              'assets/ic_about2.png',
                                              height: 50.0,
                                              width: 50.0,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                              Translations.of(context)
                                                  .text('about_our_cust_title'),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: Colors.black,
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 15),
                                            child: Icon(FontAwesomeIcons.bolt,
                                                color: Color(0xFFFF972F)),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 21.5, top: 15),
                                              child: Text(
                                                  Translations.of(context).text(
                                                      'about_our_cust_content1'))),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 22),
                                            child: Icon(
                                                FontAwesomeIcons.industry,
                                                color: Color(0xFFFF972F)),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 21.5, top: 22),
                                              child: Text(
                                                  Translations.of(context).text(
                                                      'about_our_cust_content2'))),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 22),
                                              child: Icon(FontAwesomeIcons.box,
                                                  color: Color(0xFFFF972F))),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 21.5, top: 22),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_our_cust_content3'),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 22),
                                            child: Icon(FontAwesomeIcons.hotel,
                                                color: Color(0xFFFF972F)),
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 21.5, top: 22, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_our_cust_content4'),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 22),
                                            child: Icon(
                                                FontAwesomeIcons.solidBuilding,
                                                color: Color(0xFFFF972F)),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 21.5,
                                                  top: 22,
                                                  right: 14),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_our_cust_content5'),
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, top: 22, bottom: 39),
                                            child: Icon(
                                                FontAwesomeIcons.shuttleVan,
                                                color: Color(0xFFFF972F)),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 21.5,
                                                  top: 22,
                                                  bottom: 39),
                                              child: Text(
                                                  Translations.of(context).text(
                                                      'about_our_cust_content6'))),
                                        ],
                                      ),
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
                                        height: 70,
                                        margin: EdgeInsets.fromLTRB(
                                            15.0, 0.0, 0.0, 0),
                                        child: Image.asset(
                                          'assets/ic_about3.png',
                                          height: 50.0,
                                          width: 50.0,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          Translations.of(context)
                                              .text('about_5_step_title'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.keyboard_arrow_right),
                                      )
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
                                              'assets/ic_about3.png',
                                              height: 50.0,
                                              width: 50.0,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              Translations.of(context)
                                                  .text('about_5_step_title'),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                                Icons.keyboard_arrow_right),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Color(0xFFFF972F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24, top: 20, right: 14),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_5_step_content1_title'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 60, top: 7, right: 14),
                                          child: Text(
                                            Translations.of(context).text(
                                                'about_5_step_content1_c'),
                                            style: TextStyle(
                                                color: Color(0xFF5C727D),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 10),
                                            child: Text(
                                              '2',
                                              style: TextStyle(
                                                  color: Color(0xFFFF972F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25, top: 10),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_5_step_content2_title'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 60, top: 7, right: 14),
                                          child: Text(
                                            Translations.of(context).text(
                                                'about_5_step_content2_c'),
                                            style: TextStyle(
                                                color: Color(0xFF5C727D),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 10),
                                            child: Text(
                                              '3',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFFF972F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25, top: 10, right: 14),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_5_step_content3_title'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 60, top: 7, right: 14),
                                          child: Text(
                                            Translations.of(context).text(
                                                'about_5_step_content3_c'),
                                            style: TextStyle(
                                                color: Color(0xFF5C727D),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 10),
                                            child: Text(
                                              '4',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFFF972F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25, top: 10),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_5_step_content4_title'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 60, top: 7, right: 14),
                                          child: Text(
                                            Translations.of(context).text(
                                                'about_5_step_content4_c'),
                                            style: TextStyle(
                                                color: Color(0xFF5C727D),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, top: 10),
                                            child: Text(
                                              '5',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFFF972F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25, top: 10, right: 14),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_5_step_content5_title'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 60,
                                              top: 7,
                                              right: 14,
                                              bottom: 25),
                                          child: Text(
                                            Translations.of(context).text(
                                                'about_5_step_content5_c'),
                                            style: TextStyle(
                                                color: Color(0xFF5C727D),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )),
                                      SizedBox(height: 20)
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, bottom: 2),
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
