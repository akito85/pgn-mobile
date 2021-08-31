import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 70.0, left: 10.0, right: 10.0),
      width: 200,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:5.0),
              // width: 295,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Perusahaan / Grup',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:5.0),
              // width: 295,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Sektor Industri',
                  suffixIcon: IconButton(
                    icon: Image.asset('assets/icon_dropdown.png'),
                    // iconSize: 5.0,
                    onPressed: (){

                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:5.0),
              // width: 295,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Orang yang dapat dihubungi',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:5.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.0,
                    child: TextFormField(
                      initialValue: '+62',
                      decoration: InputDecoration(
                        labelText: 'INA',
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0,),
                  Container(
                    width: 325,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:5.0),
              // width: 295,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value.isEmpty){
                    return 'Please input valid email!';
                  }
                },
              ),
            ),
            Container(
              height: 45.0,
              alignment: Alignment(0.0, 1.0),
              margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).primaryColor,
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){

                },
              )
            ),
          ],
        ),
      ),
    );
  }
}