import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialogNotif extends StatelessWidget {
  final String fcmToken;
  final String deviceID;
  final String messge;
  CustomDialogNotif(this.fcmToken, this.deviceID, this.messge);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Container(
      key: key,
      color: Colors.white,
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5, right: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              children: <Widget>[
                Text(messge ?? '-'),
                GestureDetector(
                  child: Text(
                    'FCM Token : ${fcmToken ?? '-'}',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {},
                  onLongPress: () {
                    // //print('INI HASIL FCMTOKENYA : $fcmToken');

                    Clipboard.setData(ClipboardData(
                      text: fcmToken,
                    ));
                    key.currentState.showSnackBar(SnackBar(
                      content: Text('Copied to clipboard!'),
                    ));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('Device ID : ${deviceID ?? ''}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                          text: fcmToken,
                        ));
                        key.currentState.showSnackBar(SnackBar(
                          content: Text('Copied to clipboard!'),
                        ));
                      },
                      child: Text(
                        'Click to COPY FCM Token',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
