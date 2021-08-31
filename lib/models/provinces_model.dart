class GetProvinces {
  List<DataProvinces> data;

  GetProvinces({this.data});

  factory GetProvinces.fromJson(Map<String, dynamic> json){
    return GetProvinces(
      data : parseDataProvince(json['data']),
    );
  }

  static List<DataProvinces> parseDataProvince(datasJson){
    var list = datasJson as List;
    List<DataProvinces> datasProvinces =
    list.map((data) => DataProvinces.fromJson(data)).toList();
    return datasProvinces;
  }
}

class DataProvinces{
  String id;
  String name;
  int value;
  List<UnitJBahanBakarBisnis> unit;

  DataProvinces({this.id, this.name, this.unit, this.value});

  factory DataProvinces.fromJson(Map<String, dynamic> json){
    if((json['unit']) == true)
    {
      return DataProvinces(
        id: json['id'],
        name: json['name'],
        unit : parseDataUnit(json['unit']),
      );
    }
    else if(json['title'] != null)
    {
      return DataProvinces(
        id: json['id'],
        name: json['title'],
      );
    }
    else if(json['value'] != null)
    {
      return DataProvinces(
        id: json['id'],
        value: json['value'],
      );
    }
    else{
      return DataProvinces(
        id: json['id'],
        name: json['name'],
      );
    }
    
  }
  static List<UnitJBahanBakarBisnis> parseDataUnit(datasJson){
    var list = datasJson as List;
    List<UnitJBahanBakarBisnis> datasUnit =
    list.map((data) => UnitJBahanBakarBisnis.fromJson(data)).toList();
    return datasUnit;
  }
}
//////////////////////////////////////////////////////////////////
class GetJenisBBakarBisnis {
  List<DataJBahanBakarBisnis> data;

  GetJenisBBakarBisnis({this.data});

  factory GetJenisBBakarBisnis.fromJson(Map<String, dynamic> json){
    return GetJenisBBakarBisnis(
      data : parseDataJBahanBakar(json['data']),
    );
  }

  static List<DataJBahanBakarBisnis> parseDataJBahanBakar(datasJson){
    var list = datasJson as List;
    List<DataJBahanBakarBisnis> datasBahanBakar =
    list.map((data) => DataJBahanBakarBisnis.fromJson(data)).toList();
    return datasBahanBakar;
  }
}

class DataJBahanBakarBisnis{
  String id;
  String name;
  List<UnitJBahanBakarBisnis> unit;

  DataJBahanBakarBisnis({this.id, this.name, this.unit});

  factory DataJBahanBakarBisnis.fromJson(Map<String, dynamic> json){
    return DataJBahanBakarBisnis(
      id: json['id'],
      name: json['name'],
      unit : parseDataUnit(json['unit']),
    );
  }
   static List<UnitJBahanBakarBisnis> parseDataUnit(datasJson){
    var list = datasJson as List;
    List<UnitJBahanBakarBisnis> datasUnit =
    list.map((data) => UnitJBahanBakarBisnis.fromJson(data)).toList();
    return datasUnit;
  }
}

class UnitJBahanBakarBisnis{
  String idUnit;
  String nameUnit;
  
  UnitJBahanBakarBisnis({this.idUnit, this.nameUnit});

  factory UnitJBahanBakarBisnis.fromJson(Map<String, dynamic> json){
    return UnitJBahanBakarBisnis(
      idUnit: json['id'],
      nameUnit: json['label'],
    );
  }
}