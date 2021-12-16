class PenghentianSementaraModel {
  List<DataPenghentianSementara> dataPenghentianSementara;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PenghentianSementaraModel(
      {this.code, this.dataPenghentianSementara, this.message, this.nextPage});
  factory PenghentianSementaraModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PenghentianSementaraModel(
          code: json['code'], message: json['message']);
    } else {
      return PenghentianSementaraModel(
          dataPenghentianSementara:
              parsedDataPenghentianSementara(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<DataPenghentianSementara> parsedDataPenghentianSementara(
      dataJson) {
    var list = dataJson as List;
    List<DataPenghentianSementara> dataPenghentianSementara =
        list.map((data) => DataPenghentianSementara.fromJson(data)).toList();
    return dataPenghentianSementara;
  }
}

class DataPenghentianSementara {
  int id;
  String idCust;
  String name;
  String reason;
  String createdAt;
  String subDateSuspend;
  String subDateEnable;
  String status;

  DataPenghentianSementara(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDateSuspend,
      this.subDateEnable});

  factory DataPenghentianSementara.fromJson(Map<String, dynamic> json) {
    return DataPenghentianSementara(
      id: json['id'],
      subDateSuspend: json['submission_suspend_date'],
      status: json['progress_status'],
      reason: json['reason'],
      idCust: json['customer_id'],
      name: json['customer_name'],
      createdAt: json['created_at'],
      subDateEnable: json['submission_enable_date'],
    );
  }
}

/// MODEL SUCCES CREATE BERHENTI BERLANGGANAN
class CreatePenghentianSementara {
  DataCreate dataCreate;
  CreatePenghentianSementara({this.dataCreate});

  factory CreatePenghentianSementara.fromJson(Map<String, dynamic> json) {
    return CreatePenghentianSementara(
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

class DetailPenghentianSementara {
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
  String subDateSuspend;
  String subDateEnable;
  String reason;
  String sign;
  String status;
  String createdAt;
  DetailPenghentianSementara(
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
      this.subDateEnable,
      this.subDateSuspend});
  factory DetailPenghentianSementara.fromJson(Map<String, dynamic> json) {
    return DetailPenghentianSementara(
      id: json['id'],
      subDateSuspend: json['submission_suspend_date'],
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
      subDateEnable: json['submission_enable_date'],
    );
  }
}
