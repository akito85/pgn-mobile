import 'package:flutter/material.dart';

class CMVisitDetail extends StatefulWidget {
  @override
  _CMVisitDetailState createState() => _CMVisitDetailState();
}

class _CMVisitDetailState extends State<CMVisitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('NOXUS Ideata Prima PT - Report',
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12, left: 16, right: 16),
            decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Site/Business Visit',
                    style: TextStyle(
                        color: const Color(0xFF5C727D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Site/Business Visit',
                    style: TextStyle(
                        color: const Color(0xFF5C727D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  child: Text('NOXUS Ideata Prima PT',
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color(0xFF427CEF),
                          fontWeight: FontWeight.w600))),
              Container(
                margin: EdgeInsets.only(top: 4),
                alignment: Alignment.topLeft,
                child: Text('ID. 832150128',
                    style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF5C727D),
                        fontWeight: FontWeight.w600)),
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 12),
            alignment: Alignment.topLeft,
            child: Text(
              'Jl. Pagedangan Raya Utara no.127, Cengkareng, Jakarta Barat, Indonesia 12345',
              style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Divider(color: Colors.blueGrey),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Contact Person',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF455055)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Mr Arif Nugroho',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF455055)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Contact Person',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF455055)),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Mr Arif Nugroho',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF455055)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email Address',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF455055)),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'product.information@noxusindonesia.co.id',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF455055)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Divider(color: Colors.blueGrey),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Costumer Complaint Handling',
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
                    'Suspendisse eu rhoncus arcu. Donec ac purus lectus. Vivamus dapibus maximus tellus, gravida tincidunt purus faucibus in. Vestibulum porttitor massa eu feugiat volutpat.',
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
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'CM Visit Reports',
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
                    'Suspendisse eu rhoncus arcu. Donec ac purus lectus. Vivamus dapibus maximus tellus, gravida tincidunt purus faucibus in. Vestibulum porttitor massa eu feugiat volutpat. Etiam malesuada commodo lorem eget imperdiet. Aliquam varius commodo odio, nec molestie turpis convallis eget. Nulla vitae tempor orci, a auctor enim. Etiam vestibulum elit vitae sem aliquam semper. Pellentesque maximus augue accumsan ligula pharetra condimentum. In id tincidunt elit, at sollicitudin lectus. Proin gravida nunc quis eros bibendum porta. In hac habitasse platea dictumst. Nunc ut tellus sit amet tortor interdum tristique vitae ut eros. Donec vestibulum enim quis risus tempus elementum. Nam vitae massa ut libero tempus tincidunt. Nulla facilisi. Fusce dapibus ex felis, id sodales purus consequat eu. Proin pretium congue metus. Sed dapibus, mi non viverra iaculis, tortor ligula tempus justo, in sollicitudin dolor orci consectetur leo. Duis ut viverra enim. Proin lacus ipsum, tempor non felis at, porta tincidunt odio. Fusce vel erat sollicitudin, cursus nibh at, elementum ante. Vivamus elit mauris, consequat eget bibendum sed, blandit eget orci. Vivamus ut laoreet lacus. Donec tempus ipsum quis sapien egestas posuere. Vestibulum imperdiet nibh non turpis interdum, vitae maximus tortor mattis.',
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
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Documentation',
                      style: TextStyle(
                          color: const Color(0xFF427CEF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, int index) {
                        return _listPhotos(context);
                      },
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}

Widget _listPhotos(BuildContext context) {
  return Container(
    width: 100,
    height: 100,
    margin: EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text('Test 1',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
  );
}
