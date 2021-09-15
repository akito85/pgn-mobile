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

///////////////////////GET Virtual Card
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
///////////////////////GET Virtual Card

///////////////////////GET History Gas Point
class GasPointHistoryModel {
  List<HistoryGasPoint> dataGPHistory;
  String message;
  dynamic code;
  GasPointPaging gasPointPaging;
  GasPointHistoryModel(
      {this.code, this.dataGPHistory, this.message, this.gasPointPaging});
  factory GasPointHistoryModel.fromJson(Map<String, dynamic> json) {
    return GasPointHistoryModel(
      message: json['message'],
      code: json['code'],
      dataGPHistory: parseDataGPHistory(json['data']),
      gasPointPaging: GasPointPaging.fromJson(json['paging']),
    );
  }
  static List<HistoryGasPoint> parseDataGPHistory(dataJson) {
    var list = dataJson as List;
    List<HistoryGasPoint> dataHistoryGP =
        list.map((data) => HistoryGasPoint.fromJson(data)).toList();
    return dataHistoryGP;
  }
}

// class DataGPHistory {
//   String customerId;
//   List<HistoryGasPoint> historyGasPoint;
//   int totalItem;
//   int totalPage;
//   int currentPage;
//   String nextPageUrl;

//   DataGPHistory(
//       {this.currentPage,
//       this.customerId,
//       this.historyGasPoint,
//       this.nextPageUrl,
//       this.totalItem,
//       this.totalPage});

//   factory DataGPHistory.fromJson(Map<String, dynamic> json) {
//     return DataGPHistory(
//       customerId: json['customer_id'],
//       totalItem: json['total'],
//       totalPage: json['total_page'],
//       currentPage: json['current_page'],
//       nextPageUrl: json['next_page_url'],
//       historyGasPoint: parseDataGPHistory(json['history']),
//     );
//   }
//   static List<HistoryGasPoint> parseDataGPHistory(dataJson) {
//     var list = dataJson as List;
//     List<HistoryGasPoint> dataHistoryGP =
//         list.map((data) => HistoryGasPoint.fromJson(data)).toList();
//     return dataHistoryGP;
//   }
// }

class HistoryGasPoint {
  int idHistory;
  String dateHistory;
  String dateHistoryFormated;
  String point;
  String type;
  String desc;
  HistoryGasPoint(
      {this.dateHistory, this.idHistory, this.point, this.type, this.desc});

  factory HistoryGasPoint.fromJson(Map<String, dynamic> json) {
    return HistoryGasPoint(
        idHistory: json['id'],
        dateHistory: json['date'],
        point: json['point'],
        type: json['type'],
        desc: json['description']);
  }
}
///////////////////////GET History Gas Point

///////////////////////GET List Rewards
class GetRewardsModel {
  String message;
  dynamic code;
  List<DataGetRewards> dataGetRewards;
  GasPointPaging gasPointPaging;

  GetRewardsModel(
      {this.dataGetRewards, this.code, this.message, this.gasPointPaging});

  factory GetRewardsModel.fromJson(Map<String, dynamic> json) {
    return GetRewardsModel(
      message: json['message'],
      code: json['code'],
      gasPointPaging: GasPointPaging.fromJson(json['paging']),
      dataGetRewards: parsedDataGetRewards(json['data']),
    );
  }
  static List<DataGetRewards> parsedDataGetRewards(dataJson) {
    var list = dataJson as List;
    List<DataGetRewards> dataGetRewards =
        list.map((data) => DataGetRewards.fromJson(data)).toList();
    return dataGetRewards;
  }
}

class DataGetRewards {
  String id;
  String nameRewards;
  int cost;
  bool isRedeemAble;
  String imgRedeem;
  bool selectedItem = false;

  DataGetRewards(
      {this.cost,
      this.id,
      this.imgRedeem,
      this.isRedeemAble,
      this.nameRewards});

  factory DataGetRewards.fromJson(Map<String, dynamic> json) {
    return DataGetRewards(
        id: json['id'],
        cost: json['cost'],
        nameRewards: json['name'],
        isRedeemAble: json['is_redeemable'],
        imgRedeem: json['image_path']);
  }
}
///////////////////////GET List Rewards

//////////////////////////POST Redeem Rewards

class PostRedeemModel {
  DataPostRedeem dataPostRedeem;
  String message;
  PostRedeemModel({this.dataPostRedeem, this.message});

  factory PostRedeemModel.fromJson(Map<String, dynamic> json) {
    return PostRedeemModel(
      dataPostRedeem: DataPostRedeem.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class DataPostRedeem {
  String id;
  String message;
  StatusPostRedeem statusPostRedeem;

  DataPostRedeem({this.id, this.message, this.statusPostRedeem});

  factory DataPostRedeem.fromJson(Map<String, dynamic> json) {
    return DataPostRedeem(
      id: json['id'],
      message: json['message'],
      statusPostRedeem: StatusPostRedeem.fromJson(
        json['status'],
      ),
    );
  }
}

class StatusPostRedeem {
  String idStat;
  String messageStat;

  StatusPostRedeem({this.idStat, this.messageStat});
  factory StatusPostRedeem.fromJson(Map<String, dynamic> json) {
    return StatusPostRedeem(
      idStat: json['id'],
      messageStat: json['message'],
    );
  }
}
//////////////////////////POST Redeem Rewards

//////////////////////////GET Redeem History

class RedeemHistoryModel {
  String message;
  dynamic code;
  List<DataGetRedeem> dataGetRedeem;
  GasPointPaging gasPointPaging;

  RedeemHistoryModel(
      {this.dataGetRedeem, this.code, this.message, this.gasPointPaging});

  factory RedeemHistoryModel.fromJson(Map<String, dynamic> json) {
    return RedeemHistoryModel(
      message: json['message'],
      code: json['code'],
      gasPointPaging: GasPointPaging.fromJson(json['paging']),
      dataGetRedeem: parsedDataGetRedeem(json['data']),
    );
  }
  static List<DataGetRedeem> parsedDataGetRedeem(dataJson) {
    var list = dataJson as List;
    List<DataGetRedeem> dataGetRewards =
        list.map((data) => DataGetRedeem.fromJson(data)).toList();
    return dataGetRewards;
  }
}

class DataGetRedeem {
  int id;
  String imgUrl;
  String name;
  String redeemDate;
  int pointRewardCost;
  String statusRedeem;

  DataGetRedeem(
      {this.id,
      this.imgUrl,
      this.name,
      this.pointRewardCost,
      this.redeemDate,
      this.statusRedeem});

  factory DataGetRedeem.fromJson(Map<String, dynamic> json) {
    return DataGetRedeem(
        id: json['id'],
        imgUrl: json['image_path'],
        name: json['name'],
        redeemDate: json['redeem_date'],
        pointRewardCost: json['point_reward_cost'],
        statusRedeem: json['status_redeem_transaction']);
  }
}

//////////////////////////GET Redeem History

class GasPointPaging {
  String currentPage;
  String nextPage;
  String prevPage;
  int lengthPage;

  GasPointPaging(
      {this.currentPage, this.lengthPage, this.nextPage, this.prevPage});

  factory GasPointPaging.fromJson(Map<String, dynamic> json) {
    return GasPointPaging(
        currentPage: json['current'],
        nextPage: json['next'],
        prevPage: json['prev'],
        lengthPage: json['count']);
  }
}
