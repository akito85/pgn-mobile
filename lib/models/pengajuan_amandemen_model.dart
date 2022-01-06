class BBGModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  BBGModel({this.code, this.data, this.message, this.nextPage});
  factory BBGModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return BBGModel(code: json['code'], message: json['message']);
    } else {
      return BBGModel(
          data: parsedDataBBG(json['data']), nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataBBG(dataJson) {
    var list = dataJson as List;
    List<Datas> datas = list.map((data) => Datas.fromJson(data)).toList();
    return datas;
  }
}

class Datas {
  int id;
  String idCust;
  String name;
  String reason;
  String createdAt;
  String subDate;
  String status;

  Datas(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDate});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
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

/// MODEL SUCCES CREATE PENGALIRAN KEMBALI
class Create {
  DataCreate dataCreate;
  Create({this.dataCreate});

  factory Create.fromJson(Map<String, dynamic> json) {
    return Create(
      dataCreate: DataCreate.fromJson(json['data']),
    );
  }
}

class DataCreate {
  String message;
  String formId;
  DataCreate({this.message, this.formId});

  factory DataCreate.fromJson(Map<String, dynamic> json) {
    if (json['report_number'] != null)
      return DataCreate(
          message: json['message'], formId: json['report_number']);

    return DataCreate(
      message: json['message'],
    );
  }
}

/// MODEL Get Detail Berhenti Berlangganan

class DetailData {
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
  String electricalPower;
  String electricalBillProof;
  String npwpNumb;
  String npwpFile;
  String ktpAddress;
  String custGroup;
  String mediaInfo;
  String ktpFile;

  DetailData(
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
      this.subDate,
      this.electricalBillProof,
      this.electricalPower,
      this.npwpFile,
      this.npwpNumb,
      this.custGroup,
      this.mediaInfo,
      this.ktpAddress,
      this.ktpFile});
  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
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
        kabupaten: json['kota_kabupaten'],
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
        electricalBillProof: json['electricity_bill_proof'],
        electricalPower: json['electrical_power'],
        npwpFile: json['npwp_file'],
        npwpNumb: json['npwp_number'],
        custGroup: json['customer_group'],
        mediaInfo: json['info_media'],
        ktpAddress: json['ktp_address'],
        ktpFile: json['ktp_file']);
  }
}
