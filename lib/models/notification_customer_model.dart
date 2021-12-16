class NotifCustModel {
  List<DataNotifList> data;
  List<dynamic> paging;
  String message;

  NotifCustModel({this.data, this.message, this.paging});

  factory NotifCustModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return NotifCustModel(
        data: parseDataListNotif(json['data']),
        paging: json['except'],
      );
    else
      return NotifCustModel(message: json['message']);
  }

  static List<DataNotifList> parseDataListNotif(datasJson) {
    var list = datasJson as List;
    List<DataNotifList> datasListNotif =
        list.map((data) => DataNotifList.fromJson(data)).toList();
    return datasListNotif;
  }
}

class DataNotifList {
  int id;
  Payload payload;

  DataNotifList({this.id, this.payload});

  factory DataNotifList.fromJson(Map<String, dynamic> json) {
    return DataNotifList(
      id: json['id'],
      payload: Payload.fromJson(json['payload']),
    );
  }
}

class Payload {
  String type;
  String title;
  String body;
  String imageUrl;
  String formId;
  String attachmentUrl;
  String lastStat;
  Payload(
      {this.attachmentUrl,
      this.body,
      this.formId,
      this.imageUrl,
      this.lastStat,
      this.title,
      this.type});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      type: json['type'],
      title: json['title'],
      body: json['body'],
      imageUrl: json['image_url'],
      formId: json['form_id'],
      attachmentUrl: json['attachment_url'],
      lastStat: json['last_status'],
    );
  }
}

////// Notification Detail
class DataNotif {
  int id;
  String message;
  Payload payload;

  DataNotif({this.id, this.payload, this.message});

  factory DataNotif.fromJson(Map<String, dynamic> json) {
    if (json['message'] == null)
      return DataNotif(
        id: json['id'],
        payload: Payload.fromJson(json['payload']),
      );
    else
      return DataNotif(message: json['message']);
  }
}
