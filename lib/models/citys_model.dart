class GetCitys {
  List<DataCitys> data;

  GetCitys({this.data});

  factory GetCitys.fromJson(Map<String, dynamic> json){
    return GetCitys(
      data : parseDataProvince(json['data']),
    );
  }

  static List<DataCitys> parseDataProvince(datasJson){
    var list = datasJson as List;
    List<DataCitys> datasProvinces =
    list.map((data) => DataCitys.fromJson(data)).toList();
    return datasProvinces;
  }
}

class DataCitys{
  String id;
  String name;

  DataCitys({this.id, this.name});

  factory DataCitys.fromJson(Map<String, dynamic> json){
    return DataCitys(
      id: json['id'],
      name: json['name']
    );
  }
}