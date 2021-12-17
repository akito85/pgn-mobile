class KlaimAsuransiModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  KlaimAsuransiModel({this.code, this.data, this.message, this.nextPage});
  factory KlaimAsuransiModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return KlaimAsuransiModel(code: json['code'], message: json['message']);
    } else {
      return KlaimAsuransiModel(
          data: parsedDataKlaimAsuransi(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataKlaimAsuransi(dataJson) {
    var list = dataJson as List;
    List<Datas> datas = list.map((data) => Datas.fromJson(data)).toList();
    return datas;
  }
}

class Datas {
  int id;
  String idCust;
  String name;
  String createdAt;
  String infoMedia;
  String status;

  Datas(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.status,
      this.infoMedia});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      id: json['id'],
      infoMedia: json['info_media'],
      status: json['progress_status'],
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
  DataCreate({this.message});

  factory DataCreate.fromJson(Map<String, dynamic> json) {
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
  String claimFile;
  String sign;
  String status;
  String createdAt;
  String mediaType;
  String npwpFile;
  String npwpNumb;
  String ktpAddress;
  DetailData({
    this.address,
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
    this.claimFile,
    this.rt,
    this.rw,
    this.sign,
    this.status,
    this.street,
    this.mediaType,
    this.ktpAddress,
    this.npwpFile,
    this.npwpNumb,
  });
  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      id: json['id'],
      status: json['progress_status'],
      claimFile: json['claim_file'],
      mediaType: json['info_media'],
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
      npwpFile: json['npwp_file'],
      npwpNumb: json['npwp_number'],
      ktpAddress: json['ktp_address'],
    );
  }
}
