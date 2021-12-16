import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pgn_mobile/models/pengaliran_kembali_model.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_amandemen/bbg_list.dart';
import 'package:pgn_mobile/screens/pengajuan_layanan/pengajuan_amandemen/perubahan_list.dart';

class PengajuanAmandemenList extends StatefulWidget {
  @override
  _PengajuanAmandemenListState createState() => _PengajuanAmandemenListState();
}

class _PengajuanAmandemenListState extends State<PengajuanAmandemenList>
    with TickerProviderStateMixin {
  String userName = '';
  String userID = '';
  String nextPage = '';
  List<Datas> datas = [];
  ScrollController _scrollController = ScrollController();
  final storageCache = FlutterSecureStorage();
  Widget appBarTitle = new Text(
    "Pengajuan Amandemen",
    style: TextStyle(color: Colors.white),
  );
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Pengajuan Amandemen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  width: 380,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xff427CEF),
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Color(0xff427CEF),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF4578EF),
                    ),
                    tabs: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Tab(
                          text: 'Pengalihan BBG',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Tab(
                          text: 'Perubahan Segmen/Kelompok Pelanggan',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: BBGList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SegmenList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
