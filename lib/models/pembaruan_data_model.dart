class PembaruanDataModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PembaruanDataModel({this.code, this.data, this.message, this.nextPage});
  factory PembaruanDataModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PembaruanDataModel(code: json['code'], message: json['message']);
    } else {
      return PembaruanDataModel(
          data: parsedDataPembaruanDataModel(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataPembaruanDataModel(dataJson) {
    var list = dataJson as List;
    List<Datas> datas = list.map((data) => Datas.fromJson(data)).toList();
    return datas;
  }
}

class Datas {
  int id;
  String idCust;
  String name;
  String nomorNpwp;
  String createdAt;
  String mediaType;
  String status;

  Datas(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.nomorNpwp,
      this.status,
      this.mediaType});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      id: json['id'],
      mediaType: json['info_media'],
      status: json['progress_status'],
      nomorNpwp: json['npwp_number'],
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
  String nomorNpwp;
  String npwpFile;
  String mediaType;
  String sign;
  String status;
  String createdAt;
  String ktpAddress;
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
      this.npwpFile,
      this.rt,
      this.rw,
      this.sign,
      this.status,
      this.street,
      this.nomorNpwp,
      this.mediaType,
      this.ktpAddress});
  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      id: json['id'],
      nomorNpwp: json['npwp_number'],
      status: json['progress_status'],
      npwpFile: json['npwp_file'],
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
      mediaType: json['info_media'],
      ktpAddress: json['ktp_address'],
    );
  }
}
