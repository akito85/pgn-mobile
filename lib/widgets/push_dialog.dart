import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialog extends StatelessWidget {
  final String urlImg;
  final String redirectURL;
  // final String title;
  // final String body;
  CustomDialog(this.urlImg, this.redirectURL);

  @override
  Widget build(BuildContext context) {
    print("INI REDIRET URL: $redirectURL");
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                // top: 18.0,
                ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (redirectURL != "null")
                  InkWell(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(urlImg, fit: BoxFit.fill),
                    ),
                    onTap: () {
                      _launchURL(redirectURL);
                    },
                  ),
                if (redirectURL == "null")
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(urlImg, fit: BoxFit.fill),
                  ),
                if (redirectURL != "null")
                  InkWell(
                    child: Container(
                        width: 50,
                        height: 40,
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 35, right: 35),
                        padding: EdgeInsets.only(left: 35, right: 35),
                        decoration: BoxDecoration(
                            color: Color(0xFF427CEF),
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Center(
                          child: Text(
                            "Open URL",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    onTap: () {
                      _launchURL(redirectURL);
                      Navigator.pop(context);
                    },
                  )
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

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
