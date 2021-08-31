import 'package:flutter/material.dart';
import 'package:pgn_mobile/models/provinces_model.dart';
import 'package:provider/provider.dart';
import 'package:pgn_mobile/services/register_residential.dart';

class SearchDropDown extends StatefulWidget {
  final Future<GetProvinces> data;
  final String title;
  @override
  SearchDropDown({this.data, this.title});
  SearchDDState createState() => SearchDDState(data, title);
}

class SearchDDState extends State<SearchDropDown> {
  TextEditingController editingController = TextEditingController();
  Future<GetProvinces> data;
  String title;
  List<DataProvinces> dataProvinces;
  SearchDDState(this.data, this.title);
  var items = List<DataProvinces>();
  final duplicateItems = List<DataProvinces>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query, Future<GetProvinces> getProvince) {
    print('ini query: $query');
    List<DataProvinces> dummySearchList = List<DataProvinces>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      print('masuk ke sini, query not null: ${duplicateItems.length}');
      List<DataProvinces> dummyListData = List<DataProvinces>();
      print('sampai kesini: ${dummyListData.length}');

      FutureBuilder<GetProvinces>(
          future: getProvince,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Column(
                children: <Widget>[LinearProgressIndicator()],
              );

            return ListView.builder(
              itemCount: snapshot.data.data.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (snapshot.data.data[i].name.contains(query)) {
                  print(
                      'ini hasil dari query list: ${snapshot.data.data[i].name}');
                  setState(() {
                    return i < snapshot.data.data.length
                        ? _buildRow(snapshot.data.data[i])
                        : SizedBox(
                            height: 10.0,
                          );
                  });
                }
              },
            );
          });
      // dataProvinces.forEach((item) {
      //   print('item dummy data: ${item.name}');
      //   if(item.name.contains(query)) {
      //     dummyListData.add(item);
      //   }
      // });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      // drawer: Drawer(
      //   child: NavigationDrawer(),
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value, data);
                  print("ini value searchnya $value");
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ),
            ),
            Expanded(
              child: _buildContent(context, data),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Future<GetProvinces> getProvince) {
    return FutureBuilder<GetProvinces>(
        future: getProvince,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Column(
              children: <Widget>[LinearProgressIndicator()],
            );
          return ListView.builder(
            itemCount: snapshot.data.data.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return i < snapshot.data.data.length
                  ? _buildRow(snapshot.data.data[i])
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        });
  }

  Widget _buildRow(DataProvinces data) {
    print('inihasil provinsi : ${data.name}');
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      title: Text(
        data.name ?? " ",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        String sendBack = data.name.toString();
        if (title == 'Province') {
          Provider.of<RegistResidential>(context).province(
            provinceId: data.id,
            provinceName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'City') {
          Provider.of<RegistResidential>(context).city(
            townID: data.id,
            townName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'District') {
          Provider.of<RegistResidential>(context).districts(
            districtId: data.id,
            districtName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'Village') {
          Provider.of<RegistResidential>(context).villages(
            villageId: data.id,
            villageName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'BuildingType') {
          Provider.of<RegistResidential>(context).buildingType(
            buildingTypeId: data.id,
            buildingTypeName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'Building Type') {
          Provider.of<RegistResidential>(context).buildingTypeBisnis(
            buildingTypeIdBisnis: data.id,
            buildingTypeNameBisnis: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'Ownership') {
          Provider.of<RegistResidential>(context).ownership(
            ownershipId: data.id,
            ownershipName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'Sector Industri') {
          Provider.of<RegistResidential>(context).secIndustri(
            secIndustriName: data.name,
          );
          Navigator.pop(context, sendBack);
        } else if (title == 'Jenis bahan bakar') {
          print('id fuel : ${data.id}');
          Provider.of<RegistResidential>(context).jenisBahanBakarBisnis(
            jBahanBakarBisnisName: data.name,
            jBahanBakarBisnisId: data.id,
          );
          // print('id fuel : ${data.id}');
          Navigator.pop(context, sendBack);
        } else if (title == 'Penggunaan Listrik') {
          // Provider.of<RegistResidential>(context).jenisBahanBakarBisnis(
          //   jBahanBakarBisnisName: data.name,
          //   jBahanBakarBisnisId: data.name
          // );
          Navigator.pop(context, sendBack);
        }
      },
    );
  }
}

////////////////////////////////////////////////////////////////////
//DropDown Energi Listrik
class SearchDropDownElectry extends StatefulWidget {
  final Future<GetProvinces> data;
  final String title;
  @override
  SearchDropDownElectry({this.data, this.title});
  SearchElectryState createState() => SearchElectryState(data, title);
}

class SearchElectryState extends State<SearchDropDownElectry> {
  TextEditingController editingController = TextEditingController();
  Future<GetProvinces> data;
  String title;
  List<DataProvinces> dataProvinces;
  SearchElectryState(this.data, this.title);
  var items = List<DataProvinces>();
  final duplicateItems = List<DataProvinces>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query, Future<GetProvinces> getProvince) {
    print('ini query: $query');
    List<DataProvinces> dummySearchList = List<DataProvinces>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      print('masuk ke sini, query not null: ${duplicateItems.length}');
      List<DataProvinces> dummyListData = List<DataProvinces>();
      print('sampai kesini: ${dummyListData.length}');

      FutureBuilder<GetProvinces>(
          future: getProvince,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Column(
                children: <Widget>[LinearProgressIndicator()],
              );

            return ListView.builder(
              itemCount: snapshot.data.data.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (snapshot.data.data[i].name.contains(query)) {
                  setState(() {
                    return i < snapshot.data.data.length
                        ? _buildRow(snapshot.data.data[i])
                        : SizedBox(
                            height: 10.0,
                          );
                  });
                }
              },
            );
          });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value, data);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              ),
            ),
            Expanded(
              child: _buildContent(context, data),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Future<GetProvinces> getProvince) {
    return FutureBuilder<GetProvinces>(
        future: getProvince,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Column(
              children: <Widget>[LinearProgressIndicator()],
            );
          return ListView.builder(
            itemCount: snapshot.data.data.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return i < snapshot.data.data.length
                  ? _buildRow(snapshot.data.data[i])
                  : SizedBox(
                      height: 10.0,
                    );
            },
          );
        });
  }

  Widget _buildRow(DataProvinces data) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      title: Text(
        data.value.toString() ?? " ",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        String sendBack = data.value.toString();
        Provider.of<RegistResidential>(context).electryPowerInstal(
            powerInstalId: data.id, powerInstalVal: data.value.toString());
        Navigator.pop(context, sendBack);
      },
    );
  }
}
