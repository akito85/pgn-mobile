class SegmenModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  SegmenModel({this.code, this.data, this.message, this.nextPage});
  factory SegmenModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return SegmenModel(code: json['code'], message: json['message']);
    } else {
      return SegmenModel(
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
  DataCreate({this.message});

  factory DataCreate.fromJson(Map<String, dynamic> json) {
    return DataCreate(
      message: json['message'],
    );
  }
}

/// MODEL Get Detail Segmen

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
  String custGroup;
  String custSubGroup;
  int minMonth;
  int maxMonth;
  int avgMonth;
  int hourDay;
  int dayWeek;
  CustEquip custEquip;
  String npwpNumb;
  String npwpFile;
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
      this.reason,
      this.rt,
      this.rw,
      this.sign,
      this.status,
      this.street,
      this.subDate,
      this.avgMonth,
      this.custEquip,
      this.custGroup,
      this.custSubGroup,
      this.dayWeek,
      this.hourDay,
      this.maxMonth,
      this.minMonth,
      this.ktpAddress,
      this.npwpFile,
      this.npwpNumb});
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
      custGroup: json['customer_group'],
      custSubGroup: json['submission_customer_group'],
      avgMonth: json['average_volume_month'],
      minMonth: json['minimum_volume_month'],
      maxMonth: json['maximum_volume_month'],
      dayWeek: json['operational_day_week'],
      hourDay: json['operational_hour_day'],
      ktpAddress: json['ktp_address'],
      npwpFile: json['npwp_file'],
      npwpNumb: json['npwp_number'],
      custEquip: CustEquip.fromJson(json['customer_equipments']),
    );
  }
}

class CustEquip {
  List<DatasEquip> datasEquip;

  CustEquip({this.datasEquip});

  factory CustEquip.fromJson(Map<String, dynamic> json) {
    return CustEquip(
      datasEquip: parsedDatasEquip(json['data']),
    );
  }
  static List<DatasEquip> parsedDatasEquip(dataJson) {
    var list = dataJson as List;
    List<DatasEquip> datas =
        list.map((data) => DatasEquip.fromJson(data)).toList();
    return datas;
  }
}

class DatasEquip {
  String name;
  int val;

  DatasEquip({this.name, this.val});

  factory DatasEquip.fromJson(Map<String, dynamic> json) {
    return DatasEquip(
      name: json['Name'],
      val: json['Value'],
    );
  }
}
