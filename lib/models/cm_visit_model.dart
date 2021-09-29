import 'package:pgn_mobile/models/down_usage_detail_model.dart';

class CMVisitList {
  List<CMVisitModel> data;
  MetaData metadata;

  CMVisitList({this.data, this.metadata});

  factory CMVisitList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return CMVisitList(data: parseDataCMVisit(json['data']));
    } else {
      return CMVisitList(metadata: json['meta']);
    }
  }
  static List<CMVisitModel> parseDataCMVisit(dataJson) {
    var list = dataJson as List;
    List<CMVisitModel> datasCmVisit =
        list.map((data) => CMVisitModel.fromJson(data)).toList();
    return datasCmVisit;
  }
}

class CMVisitModel {
  final String id;
  final CustomerCmModel customerCmModel;
  final String reportDate;
  final String visitType;
  final String activityType;
  final String activityDescription;
  final ContactPersonModel contactPersonModel;
  final String report;

  CMVisitModel(
      {this.id,
      this.customerCmModel,
      this.reportDate,
      this.visitType,
      this.activityType,
      this.activityDescription,
      this.contactPersonModel,
      this.report});

  factory CMVisitModel.fromJson(Map<String, dynamic> json) {
    return CMVisitModel(
        id: json['id'],
        customerCmModel: CustomerCmModel.fromJson(json['customer']),
        reportDate: json['report_date'],
        visitType: json['visit_type'],
        activityType: json['activity_type'],
        activityDescription: json['activity_description'],
        contactPersonModel: ContactPersonModel.fromJson(json['contact_person']),
        report: json['report']);
  }
}

class CustomerCmModel {
  final String id;
  final String name;

  CustomerCmModel({this.id, this.name});

  factory CustomerCmModel.fromJson(Map<String, dynamic> json) {
    return CustomerCmModel(id: json['id'], name: json['name']);
  }
}

class ContactPersonModel {
  final String name;
  final String address;
  final String phone;
  final String email;

  ContactPersonModel({this.name, this.address, this.email, this.phone});

  factory ContactPersonModel.fromJson(Map<String, dynamic> json) {
    return ContactPersonModel(
        name: json['name'],
        address: json['address'],
        email: json['email'],
        phone: json['phone']);
  }
}
