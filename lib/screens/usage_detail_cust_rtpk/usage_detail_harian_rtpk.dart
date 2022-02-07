import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pgn_mobile/services/app_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:pgn_mobile/models/dashboard_chart_model.dart';
import 'package:intl/intl.dart';

class HarianDetailRTPKChart extends StatefulWidget {
  HarianDetailRTPKChart({this.title, this.period});
  final String title;
  final String period;
  @override
  HarianDetailRTPKChartState createState() =>
      HarianDetailRTPKChartState(title, period);
}

class HarianDetailRTPKChartState extends State<HarianDetailRTPKChart> {
  final String title;
  final String period;

  HarianDetailRTPKChartState(this.title, this.period);

  @override
  Widget build(BuildContext context) {
    // //print('INI PERIODNYA : $period');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Translations.of(context).text('title_bar_gu_weekly_list'),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContent(context, fetchPost(context, period)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, Future<HarianDetailCustDashboard> getDailyDetail) {
    return FutureBuilder<HarianDetailCustDashboard>(
        future: getDailyDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          if (snapshot.data.message != null)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 180),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/penggunaan_gas.png'),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    snapshot.data.message,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.data.length + 1,
              itemBuilder: (context, i) {
                return i < snapshot.data.data.length
                    ? _buildRow(snapshot.data.data[i])
                    : SizedBox(
                        height: 10.0,
                      );
              });
        });
  }

  Widget _buildRow(DataHourlyUsage data) {
    return Column(
      children: <Widget>[Card1(data)],
    );
  }
}

class Card1 extends StatelessWidget {
  final DataHourlyUsage data;
  Card1(this.data);
  @override
  Widget build(BuildContext context) {
    String formatDate =
        DateFormat("dd MMM yyy").format(DateTime.parse(data.date.value));
    return ExpandableNotifier(
      child: ScrollOnExpand(
        scrollOnExpand: false,
        scrollOnCollapse: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                // for(var i in Iterable.generate(3))
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${data.date.display}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 20, top: 5),
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Meter ID: ${data.meterId}' ?? '-',
                //     style: TextStyle(
                //         fontSize: 12,
                //         color: Color(0xFF5C727D),
                //         fontWeight: FontWeight.w500),
                //   ),
                // ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 140,
                      margin: EdgeInsets.only(left: 20.0, top: 15, bottom: 15),
                      child: Text(
                        'Volume',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35.0, top: 15, bottom: 15),
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5.0, top: 15, bottom: 15),
                        child: Text(
                          data.volume.display ?? "-",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<HarianDetailCustDashboard> fetchPost(
    BuildContext context, String title) async {
  final storageCache = new FlutterSecureStorage();
  String custID = await storageCache.read(key: 'customer_id');
  final dataAgustus52649 = """{
    "data": [
        {
            "id": 137290,
            "date": {
                "value": "2021-08-07",
                "display": "07 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 0,
                "display": "0 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-14",
                "display": "14 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 1,
                "display": "1 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-21",
                "display": "21 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 1,
                "display": "1 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
{
            "id": 137290,
            "date": {
                "value": "2021-08-28",
                "display": "28 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 1,
                "display": "1 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        }
    ],
    "paging": {
        "current": "",
        "prev": "",
        "next": "eyJpZCI6MTM3MjkwLCJkYXRlIjoiMjAyMS0wOS0wMSJ9",
        "count": 1
    },
    "meta": {
        "api_version": null
    }
}""";
  final dataAgustus52586 = """{
    "data": [
        {
            "id": 137290,
            "date": {
                "value": "2021-08-07",
                "display": "07 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 0,
                "display": "0 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-14",
                "display": "14 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 2,
                "display": "2 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-21",
                "display": "21 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 4,
                "display": "4 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
{
            "id": 137290,
            "date": {
                "value": "2021-08-28",
                "display": "28 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 3,
                "display": "3 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        }
    ],
    "paging": {
        "current": "",
        "prev": "",
        "next": "eyJpZCI6MTM3MjkwLCJkYXRlIjoiMjAyMS0wOS0wMSJ9",
        "count": 1
    },
    "meta": {
        "api_version": null
    }
}""";
  final dataAgustus00056384 = """{
    "data": [
        {
            "id": 137290,
            "date": {
                "value": "2021-08-07",
                "display": "07 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 0,
                "display": "0 m3",
                "unit": {
                    "id": "3",
                    "display": "m3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-14",
                "display": "14 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 2,
                "display": "2 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
        {
            "id": 137290,
            "date": {
                "value": "2021-08-21",
                "display": "21 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 3,
                "display": "3 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        },
{
            "id": 137290,
            "date": {
                "value": "2021-08-28",
                "display": "28 Aug 2021"
            },
            "meter_id": "1104600524",
            "pressure": {
                "value": 2,
                "display": "2.28 BarA",
                "unit": {
                    "id": "8",
                    "display": "BarA"
                }
            },
            "correction_factor": "2.16",
            "corrected_index": {
                "value": 244233,
                "display": "244,233.82 Sm3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "uncorrected_index": {
                "value": 891656,
                "display": "891,656.30 m3",
                "unit": {
                    "id": "2",
                    "display": "m3"
                }
            },
            "temperature": {
                "value": 27,
                "display": "27.40 Celsius",
                "unit": {
                    "id": "9",
                    "display": "Celsius"
                }
            },
            "volume": {
                "value": 3,
                "display": "3 m3",
                "unit": {
                    "id": "3",
                    "display": "Sm3"
                }
            },
            "energy": {
                "value": 46,
                "display": "46.22 MMBtu",
                "unit": {
                    "id": "1",
                    "display": "MMBtu"
                }
            },
            "meter_capacity": {
                "value": 100,
                "display": "100.00 m3/hour",
                "unit": {
                    "id": "6",
                    "display": "m3/hour"
                }
            },
            "meter_status": {
                "id": "0",
                "display": "Normal"
            },
            "capacity_percentage": "0.00"
        }
    ],
    "paging": {
        "current": "",
        "prev": "",
        "next": "eyJpZCI6MTM3MjkwLCJkYXRlIjoiMjAyMS0wOS0wMSJ9",
        "count": 1
    },
    "meta": {
        "api_version": null
    }
}""";
  HarianDetailCustDashboard harianDetailCustDashboard =
      HarianDetailCustDashboard();
  if (custID == '00056384') {
    harianDetailCustDashboard =
        HarianDetailCustDashboard.fromJson(json.decode(dataAgustus00056384));
  } else if (custID == '00052586') {
    harianDetailCustDashboard =
        HarianDetailCustDashboard.fromJson(json.decode(dataAgustus52586));
  } else {
    harianDetailCustDashboard =
        HarianDetailCustDashboard.fromJson(json.decode(dataAgustus52649));
  }

  return harianDetailCustDashboard;
}
