import 'package:flutter/material.dart';

class InstallationInspection extends StatefulWidget {
  @override
  _InstallationInspection createState() => _InstallationInspection();
}

class _InstallationInspection extends State<InstallationInspection>
    with TickerProviderStateMixin {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[_cardState(context)],
      ),
    );
  }
}

Widget _cardState(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(top: 6, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '18 November 2021',
                style: TextStyle(
                    color: Color(0xFF455055),
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                'NOXUS Ideata Prima',
                style: TextStyle(
                    color: Color(0xFF427CEF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '18 November 2021',
                style: TextStyle(
                    color: Color(0xFF5C727D),
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ));
}
