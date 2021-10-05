import 'package:pgn_mobile/models/installation_inspection_model.dart';

class InstallationInspectionResponse {
  InstallationInspectionModel data;
  Meta meta;

  InstallationInspectionResponse({this.data, this.meta});

  factory InstallationInspectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return InstallationInspectionResponse(
          data: InstallationInspectionModel.fromJson(json['data']));
    } else {
      return InstallationInspectionResponse(meta: json['meta']);
    }
  }
}

class Meta {
  String apiVersion;
  Meta({this.apiVersion});
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(apiVersion: json['api_version']);
  }
}
