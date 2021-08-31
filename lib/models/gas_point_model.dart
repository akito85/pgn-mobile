class GasPoint {
  List<DataGasPoint> data;
  String message;
  MetaGasPoint meta;
  PagingGasPoint paging;

  GasPoint({this.data, this.message, this.paging, this.meta});

  factory GasPoint.fromJson(Map<String, dynamic> json){
    if (json['data'] != null)
    return GasPoint(
      data:  parseDataGasPoint(json['data']),
      meta: MetaGasPoint.fromJson(json['meta']),
      paging: PagingGasPoint.fromJson(json['paging'])
    );
    else
    return GasPoint(
      message: json['message']
    );
  }

  static List<DataGasPoint> parseDataGasPoint(datasJson) {
    var list = datasJson as List;
    List<DataGasPoint> datasGasPoint =
        list.map((data) => DataGasPoint.fromJson(data)).toList();
    return datasGasPoint;
  }
}

class DataGasPoint{
  String id;
  String name;
  int cost;
  bool reedemable;
  String imgPath;

  DataGasPoint({this.id, this.name, this.cost, this.imgPath, this.reedemable});

  factory DataGasPoint.fromJson(Map<String, dynamic> json){
    return DataGasPoint(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      reedemable: json['is_redeemable'],
      imgPath: json['image_path']
    );
  }
}

class MetaGasPoint {
  int userPoint;

  MetaGasPoint({this.userPoint});

  factory MetaGasPoint.fromJson(Map<String, dynamic> json) {
    return MetaGasPoint(
      userPoint: json['user_point']
    );
  }
}

class PagingGasPoint {
  String current;
  String next;
  int count;

  PagingGasPoint({this.next, this.count, this.current});

  factory PagingGasPoint.fromJson(Map<String, dynamic> json) {
    return PagingGasPoint(
      current: json['current'],
      next: json['next'],
      count: json['count']
    );
  }
}