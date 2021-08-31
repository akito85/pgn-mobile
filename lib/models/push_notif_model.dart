class PushNotif {
  DataNotif datas;

  PushNotif({this.datas});
  factory PushNotif.fromJson(Map<String, dynamic> json){
    return PushNotif(
      datas: DataNotif.fromJson(json['data']),
    );
  }
}

class DataNotif {
  String senders;
  DataMessage dataMessage;

  DataNotif({this.dataMessage, this.senders});
  factory DataNotif.fromJson(Map<String, dynamic> json){
    return DataNotif(
      senders: json['sender'],
      dataMessage: DataMessage.fromJson(json['data'])
    );
  }
}

class DataMessage {
  String imageUrl;

  DataMessage({this.imageUrl});
  factory DataMessage.fromJson(Map<String, dynamic> json){
    return DataMessage(
      imageUrl: json['imageURL']
    );
  }
}