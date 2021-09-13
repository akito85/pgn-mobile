import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPgn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          Translations.of(context).text('title_bar_about' ?? '-'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/new_backgound.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 15),
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
                                        'assets/ic_about1.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_b_history_title' ?? '-'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
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
                                            'assets/ic_about1.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context)
                                                .text('about_b_history_title'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            )),
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          alignment: Alignment.centerRight,
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ))
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/briefPgn.png')),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_b_history_content1'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_b_history_content2'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_b_history_content3'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14,
                                          top: 20,
                                          right: 14,
                                          bottom: 16),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_b_history_content4'),
                                      ),
                                    )
                                  ],
                                ),
                                builder: (_, collapsed, expanded) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
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
                                            child: Text(Translations.of(context)
                                                .text(
                                                    'about_our_cust_content1'))),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 22),
                                          child: Icon(FontAwesomeIcons.industry,
                                              color: Color(0xFFFF972F)),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 21.5, top: 22),
                                            child: Text(Translations.of(context)
                                                .text(
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
                                                left: 21.5, top: 22, right: 14),
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
                                            child: Text(Translations.of(context)
                                                .text(
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
                                          child:
                                              Icon(Icons.keyboard_arrow_right),
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
                                          Translations.of(context)
                                              .text('about_5_step_content1_c'),
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
                                          Translations.of(context)
                                              .text('about_5_step_content2_c'),
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
                                          Translations.of(context)
                                              .text('about_5_step_content3_c'),
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
                                          Translations.of(context)
                                              .text('about_5_step_content4_c'),
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
                                          Translations.of(context)
                                              .text('about_5_step_content5_c'),
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
                                        'assets/ic_about4.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_product_services_title'),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      margin: EdgeInsets.only(right: 10),
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
                                            'assets/ic_about4.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context).text(
                                                'about_product_services_title'),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            )),
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          alignment: Alignment.centerRight,
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ))
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/ourProducts.png')),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_product_services_c1'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_product_services_c2'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14, top: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_product_services_c3'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 14,
                                          top: 20,
                                          right: 14,
                                          bottom: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_product_services_c4'),
                                      ),
                                    )
                                  ],
                                ),
                                builder: (_, collapsed, expanded) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
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
                                        'assets/ic_about5.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_natural_gas_b_title'),
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
                                          child: Image.asset(
                                            'assets/ic_about5.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context).text(
                                                'about_natural_gas_b_title'),
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
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            '1',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 24),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content1'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
                                          child: Text(
                                            '2',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content2'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
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
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content3'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
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
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content4'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
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
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content5'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
                                          child: Text(
                                            '6',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content6'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
                                          child: Text(
                                            '7',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content7'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17),
                                          child: Text(
                                            '8',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content8'),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 17, bottom: 13),
                                          child: Text(
                                            '9',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24,
                                                top: 17,
                                                right: 14,
                                                bottom: 20),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_natural_gas_b_content9'),
                                              textAlign: TextAlign.center,
                                            )),
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
                                        'assets/ic_about6.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_gas_leaking_title'),
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
                                          child: Image.asset(
                                            'assets/ic_about6.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context).text(
                                                'about_gas_leaking_title'),
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
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, top: 10, right: 14),
                                        child: Text(
                                          Translations.of(context).text(
                                              'about_gas_leaking_content1'),
                                          style: TextStyle(
                                              color: Color(0xFF5C727D),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, top: 15, right: 14),
                                        child: Text(
                                          Translations.of(context).text(
                                              'about_gas_leaking_content2'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 17),
                                          child: Text(
                                            '1',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_gas_leaking_content3'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF5C727D),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 17),
                                          child: Text(
                                            '2',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_gas_leaking_content4'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF5C727D),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            '3',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24, right: 14),
                                              child: Text(
                                                Translations.of(context).text(
                                                    'about_gas_leaking_content5'),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Color(0xFF5C727D),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 17),
                                          child: Text(
                                            '4',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_gas_leaking_content6'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF5C727D),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 17),
                                          child: Text(
                                            '5',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_gas_leaking_content7'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF5C727D),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30, top: 17),
                                          child: Text(
                                            '6',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 17, right: 14),
                                            child: Text(
                                              Translations.of(context).text(
                                                  'about_gas_leaking_content8'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF5C727D),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )),
                                      ],
                                    ),
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
                                        'assets/ic_about7.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_bibli_title'),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          margin: EdgeInsets.fromLTRB(
                                              15.0, 0.0, 0.0, 0),
                                          child: Image.asset(
                                            'assets/ic_about7.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context)
                                                .text('about_bibli_title'),
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_bibli_content1'),
                                        style: TextStyle(
                                          color: Colors.blue[300],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                            width: 300,
                                            padding: EdgeInsets.only(
                                                left: 24, right: 14),
                                            child: Text(
                                              Translations.of(context)
                                                  .text('about_bibli_content2'),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                            width: 300,
                                            padding: EdgeInsets.only(
                                                left: 24, right: 14),
                                            child: Text(Translations.of(context)
                                                .text('about_bibli_content3'))),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 13),
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24, top: 13, right: 14),
                                              child: Text(
                                                  Translations.of(context).text(
                                                      'about_bibli_content4'))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 14),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_bibli_content5'),
                                        style: TextStyle(
                                          color: Colors.blue[300],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24, right: 14),
                                              child: Text(
                                                  Translations.of(context).text(
                                                      'about_bibli_content6'))),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 13),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                            width: 300,
                                            padding: EdgeInsets.only(
                                                left: 24, top: 13, right: 14),
                                            child: Text(Translations.of(context)
                                                .text('about_bibli_content7'))),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Text(
                                            '3',
                                            style: TextStyle(
                                                color: Color(0xFFFF972F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                            width: 300,
                                            padding: EdgeInsets.only(
                                                left: 24, right: 14),
                                            child: Text(Translations.of(context)
                                                .text('about_bibli_content8'))),
                                      ],
                                    ),
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
                                        'assets/ic_about8.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      Translations.of(context)
                                          .text('about_contact_us_title'),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          margin: EdgeInsets.fromLTRB(
                                              15.0, 0.0, 0.0, 0),
                                          child: Image.asset(
                                            'assets/ic_about8.png',
                                            height: 50.0,
                                            width: 50.0,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            Translations.of(context)
                                                .text('about_contact_us_title'),
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
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_contact_us_content1'),
                                        style: TextStyle(
                                          color: Colors.blue[300],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_contact_us_content2'),
                                        style: TextStyle(
                                          color: Color(0xFF5C727D),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_contact_us_content3'),
                                        style: TextStyle(
                                          color: Color(0xFF5C727D),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        Translations.of(context)
                                            .text('about_contact_us_content4'),
                                        style: TextStyle(
                                          color: Color(0xFF5C727D),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20)
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
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
