import 'installation_inspection_model.dart';

class InstallationInspectionList {
  List<InstallationInspectionModel> data;
  Meta metadata;

  InstallationInspectionList({this.data, this.metadata});

  factory InstallationInspectionList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return InstallationInspectionList(
          data: parseDataInstallation(json['data']));
    } else {
      return InstallationInspectionList(metadata: json['meta']);
    }
  }

  static List<InstallationInspectionModel> parseDataInstallation(dataJson) {
    var list = dataJson as List;
    return list
        .map((data) => InstallationInspectionModel.fromJson(data))
        .toList();
  }
}

class Meta {
  String apiVersion;

  Meta({this.apiVersion});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(apiVersion: json['api_version']);
  }
}
