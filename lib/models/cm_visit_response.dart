import 'package:pgn_mobile/models/down_usage_detail_model.dart';

class CmVisitReponse {
  DataModel data;
  Meta metadata;

  CmVisitReponse({this.data, this.metadata});

  factory CmVisitReponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return CmVisitReponse(data: DataModel.fromJson(json['data']));
    } else {
      return CmVisitReponse(metadata: Meta.fromJson(json['meta']));
    }
  }
}

class DataModel {
  String message;

  DataModel({this.message});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(message: json['message']);
  }
}

class Meta {
  String apiVersion;

  Meta({this.apiVersion});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(apiVersion: json['api_version']);
  }
}
