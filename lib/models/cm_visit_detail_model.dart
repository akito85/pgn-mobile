class CmVisitDetailModel {
  CmVisitModels data;
  Meta meta;

  CmVisitDetailModel({this.data, this.meta});

  factory CmVisitDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return CmVisitDetailModel(data: CmVisitModels.fromJson(json['data']));
    } else {
      return CmVisitDetailModel(meta: Meta.fromJson(json['meta']));
    }
  }
}

class CmVisitModels {
  final String id;
  final CustomerCmModel customerCmModel;
  final String reportDate;
  final String visitType;
  final String activityType;
  final String activityDescription;
  final ContactPersonModel contactPersonModel;
  final String report;
  final List<String> images;

  CmVisitModels(
      {this.id,
      this.customerCmModel,
      this.reportDate,
      this.visitType,
      this.activityType,
      this.activityDescription,
      this.contactPersonModel,
      this.report,
      this.images});

  factory CmVisitModels.fromJson(Map<String, dynamic> json) {
    return CmVisitModels(
        id: json['id'],
        customerCmModel: CustomerCmModel.fromJson(json['customer']),
        reportDate: json['report_date'],
        visitType: json['visit_type'],
        activityType: json['activity_type'],
        activityDescription: json['activity_description'],
        contactPersonModel: ContactPersonModel.fromJson(json['contact_person']),
        report: json['report'],
        images: parseDataImages(json['images']));
  }

  static List<String> parseDataImages(dataJson) {
    return new List<String>.from(dataJson);
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

class Meta {
  String apiVersion;

  Meta({this.apiVersion});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(apiVersion: json['api_version']);
  }
}
