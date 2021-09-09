class GasPoint {
  List<DataGasPoint> data;
  String message;
  MetaGasPoint meta;
  PagingGasPoint paging;

  GasPoint({this.data, this.message, this.paging, this.meta});

  factory GasPoint.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return GasPoint(
          data: parseDataGasPoint(json['data']),
          meta: MetaGasPoint.fromJson(json['meta']),
          paging: PagingGasPoint.fromJson(json['paging']));
    else
      return GasPoint(message: json['message']);
  }

  static List<DataGasPoint> parseDataGasPoint(datasJson) {
    var list = datasJson as List;
    List<DataGasPoint> datasGasPoint =
        list.map((data) => DataGasPoint.fromJson(data)).toList();
    return datasGasPoint;
  }
}

class DataGasPoint {
  String id;
  String name;
  int cost;
  bool reedemable;
  String imgPath;

  DataGasPoint({this.id, this.name, this.cost, this.imgPath, this.reedemable});

  factory DataGasPoint.fromJson(Map<String, dynamic> json) {
    return DataGasPoint(
        id: json['id'],
        name: json['name'],
        cost: json['cost'],
        reedemable: json['is_redeemable'],
        imgPath: json['image_path']);
  }
}

class MetaGasPoint {
  int userPoint;

  MetaGasPoint({this.userPoint});

  factory MetaGasPoint.fromJson(Map<String, dynamic> json) {
    return MetaGasPoint(userPoint: json['user_point']);
  }
}

class PagingGasPoint {
  String current;
  String next;
  int count;

  PagingGasPoint({this.next, this.count, this.current});

  factory PagingGasPoint.fromJson(Map<String, dynamic> json) {
    return PagingGasPoint(
        current: json['current'], next: json['next'], count: json['count']);
  }
}

class VirtualCardGasPoint {
  DataVCGasPoint dataVCGasPoint;
  MetaVCGasPoint metaVCGasPoint;
  String message;
  dynamic code;

  VirtualCardGasPoint(
      {this.dataVCGasPoint, this.metaVCGasPoint, this.code, this.message});

  factory VirtualCardGasPoint.fromJson(Map<String, dynamic> json) {
    return VirtualCardGasPoint(
      dataVCGasPoint: DataVCGasPoint.fromJson(json['data']),
      metaVCGasPoint: MetaVCGasPoint.fromJson(json['meta']),
      message: json['message'],
      code: json['code'],
    );
  }
}

class DataVCGasPoint {
  String nameCust;
  String custId;
  String pointReward;

  DataVCGasPoint({this.custId, this.nameCust, this.pointReward});

  factory DataVCGasPoint.fromJson(Map<String, dynamic> json) {
    return DataVCGasPoint(
      nameCust: json['name'],
      custId: json['customer_id'],
      pointReward: json['point_reward'],
    );
  }
}

class MetaVCGasPoint {
  dynamic apiVersion;

  MetaVCGasPoint({this.apiVersion});

  factory MetaVCGasPoint.fromJson(Map<String, dynamic> json) {
    return MetaVCGasPoint(
      apiVersion: json['api_version'],
    );
  }
}

class GasPointHistoryModel {
  DataGPHistory dataGPHistory;
  String message;
  dynamic code;
  GasPointHistoryModel({this.code, this.dataGPHistory, this.message});
  factory GasPointHistoryModel.fromJson(Map<String, dynamic> json) {
    return GasPointHistoryModel(
      message: json['message'],
      code: json['code'],
      dataGPHistory: DataGPHistory.fromJson(json['data']),
    );
  }
}

class DataGPHistory {
  String customerId;
  List<HistoryGasPoint> historyGasPoint;
  int totalItem;
  int totalPage;
  int currentPage;
  String nextPageUrl;

  DataGPHistory(
      {this.currentPage,
      this.customerId,
      this.historyGasPoint,
      this.nextPageUrl,
      this.totalItem,
      this.totalPage});

  factory DataGPHistory.fromJson(Map<String, dynamic> json) {
    return DataGPHistory(
      customerId: json['customer_id'],
      totalItem: json['total'],
      totalPage: json['total_page'],
      currentPage: json['current_page'],
      nextPageUrl: json['next_page_url'],
      historyGasPoint: parseDataGPHistory(json['history']),
    );
  }
  static List<HistoryGasPoint> parseDataGPHistory(dataJson) {
    var list = dataJson as List;
    List<HistoryGasPoint> dataHistoryGP =
        list.map((data) => HistoryGasPoint.fromJson(data)).toList();
    return dataHistoryGP;
  }
}

class HistoryGasPoint {
  int idHistory;
  String dateHistory;
  String point;
  String type;

  HistoryGasPoint({this.dateHistory, this.idHistory, this.point, this.type});

  factory HistoryGasPoint.fromJson(Map<String, dynamic> json) {
    return HistoryGasPoint(
        idHistory: json['id'],
        dateHistory: json['date'],
        point: json['point'],
        type: json['type']);
  }
}
