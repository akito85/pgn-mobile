class BerhentiBerlanggananModel {
  List<DataBerhentiBerlanggnan> dataBerhentiBerlangganan;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  BerhentiBerlanggananModel(
      {this.code, this.dataBerhentiBerlangganan, this.message, this.nextPage});
  factory BerhentiBerlanggananModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return BerhentiBerlanggananModel(
          code: json['code'], message: json['message']);
    } else {
      return BerhentiBerlanggananModel(
          dataBerhentiBerlangganan:
              parsedDataBerhentiBerlangganan(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<DataBerhentiBerlanggnan> parsedDataBerhentiBerlangganan(
      dataJson) {
    var list = dataJson as List;
    List<DataBerhentiBerlanggnan> dataBerhentiBerlangganan =
        list.map((data) => DataBerhentiBerlanggnan.fromJson(data)).toList();
    return dataBerhentiBerlangganan;
  }
}

class DataBerhentiBerlanggnan {
  int id;
  String idCust;
  String name;
  String reason;
  String createdAt;
  String subDate;
  String status;

  DataBerhentiBerlanggnan(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDate});

  factory DataBerhentiBerlanggnan.fromJson(Map<String, dynamic> json) {
    return DataBerhentiBerlanggnan(
      id: json['id'],
      subDate: json['submission_date'],
      status: json['progress_status'],
      reason: json['reason'],
      idCust: json['customer_id'],
      name: json['customer_name'],
      createdAt: json['created_at'],
    );
  }
}

/// MODEL SUCCES CREATE BERHENTI BERLANGGANAN
class CreateBerhentiBerlangganan {
  DataCreate dataCreate;
  CreateBerhentiBerlangganan({this.dataCreate});

  factory CreateBerhentiBerlangganan.fromJson(Map<String, dynamic> json) {
    return CreateBerhentiBerlangganan(
      dataCreate: DataCreate.fromJson(json['data']),
    );
  }
}

class DataCreate {
  String message;
  DataCreate({this.message});

  factory DataCreate.fromJson(Map<String, dynamic> json) {
    return DataCreate(
      message: json['message'],
    );
  }
}

/// MODEL Get Detail Berhenti Berlangganan

class DetailBerhetiBerlangganan {
  int id;
  String custId;
  String custName;
  String gender;
  String bPlace;
  String bDate;
  String nik;
  String email;
  String phoneNumb;
  String address;
  String street;
  String rt;
  String rw;
  String kelurahan;
  String kecamatan;
  String kabupaten;
  String prov;
  String postalCode;
  String long;
  String lat;
  String locStat;
  String subDate;
  String reason;
  String sign;
  String status;
  String createdAt;
  DetailBerhetiBerlangganan(
      {this.address,
      this.bDate,
      this.bPlace,
      this.createdAt,
      this.custId,
      this.custName,
      this.email,
      this.gender,
      this.id,
      this.kecamatan,
      this.kabupaten,
      this.kelurahan,
      this.lat,
      this.locStat,
      this.long,
      this.nik,
      this.phoneNumb,
      this.postalCode,
      this.prov,
      this.reason,
      this.rt,
      this.rw,
      this.sign,
      this.status,
      this.street,
      this.subDate});
  factory DetailBerhetiBerlangganan.fromJson(Map<String, dynamic> json) {
    return DetailBerhetiBerlangganan(
      id: json['id'],
      subDate: json['submission_date'],
      status: json['progress_status'],
      reason: json['reason'],
      custId: json['customer_id'],
      custName: json['customer_name'],
      createdAt: json['created_at'],
      bDate: json['birth_date'],
      bPlace: json['birth_place'],
      gender: json['gender'],
      nik: json['id_card_number'],
      lat: json['latitude'],
      long: json['longitude'],
      rt: json['rt'],
      rw: json['rw'],
      kabupaten: json['kabupaten'],
      sign: json['customer_signature'],
      street: json['street'],
      locStat: json['person_in_location_status'],
      kecamatan: json['kecamatan'],
      kelurahan: json['kelurahan'],
      phoneNumb: json['phone_number'],
      postalCode: json['postal_code'],
      prov: json['province'],
      address: json['address'],
      email: json['email'],
    );
  }
}
