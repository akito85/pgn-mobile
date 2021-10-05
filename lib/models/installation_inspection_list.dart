import 'installation_inspection_model.dart';

class InstallationInspectionList {
  List<InstallationInspections> data;
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

  static List<InstallationInspections> parseDataInstallation(dataJson) {
    var list = dataJson as List;
    return list.map((data) => InstallationInspections.fromJson(data)).toList();
  }
}

class InstallationInspections {
  final String id;
  final CustomerModel customer;
  final String inspectionBy;
  final String inspectionDate;
  final String summary;

  InstallationInspections(
      {this.id,
      this.customer,
      this.inspectionBy,
      this.inspectionDate,
      this.summary});

  factory InstallationInspections.fromJson(Map<String, dynamic> json) {
    return InstallationInspections(
        id: json['id'],
        customer: CustomerModel.fromJson(json['customer']),
        inspectionBy: json['inspected_by'],
        inspectionDate: json['inspection_date'],
        summary: json['summary']);
  }

  static List<InspectionModel> parseDataJson(data) {
    var list = data as List;
    List<InspectionModel> datas =
        list.map((datas) => InspectionModel.fromJson(datas)).toList();
    return datas;
  }
}

class Meta {
  String apiVersion;

  Meta({this.apiVersion});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(apiVersion: json['api_version']);
  }
}
