class GetNotificationList {
  List<DataNotifList> data;
  GetNotifPaging paging;
  String message;
  GetNotificationList({this.data, this.message, this.paging});

  factory GetNotificationList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return GetNotificationList(
        data: parseDataListNotif(json['data']),
        paging: GetNotifPaging.fromJson(json['paging'])
      );
    else
      return GetNotificationList(message: json['message']);
  }

  static List<DataNotifList> parseDataListNotif(datasJson) {
    var list = datasJson as List;
    List<DataNotifList> datasListNotif =
        list.map((data) => DataNotifList.fromJson(data)).toList();
    return datasListNotif;
  }
}

class DataNotifList {
  String id;
  String aeId;
  String nameCust;
  String address;
  String imageUrl;

  DataNotifList({this.address, this.aeId, this.id, this.nameCust, this.imageUrl});

  factory DataNotifList.fromJson(Map<String, dynamic> json) {
    if(json['image_url'] != null)
    return DataNotifList(
      id: json['id'],
      aeId: json['ae_id'],
      nameCust: json['name'],
      address: json['address'],
      imageUrl: json['image_url']
    );
    else
    return DataNotifList(
      id: json['id'],
      aeId: json['ae_id'],
      nameCust: json['name'],
      address: json['address']
    );
  }
}

class GetNotifPaging {
  String current;
  String prev;
  String next;
  int count;

  GetNotifPaging({this.count, this.current, this.next, this.prev});

  factory GetNotifPaging.fromJson(Map<String, dynamic> json) {
    return GetNotifPaging(
      count: json['count'],
      prev: json['prev'],
      next: json['next'],
      current: json['current'],
    );
  }
} 
