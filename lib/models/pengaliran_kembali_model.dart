class PengaliranKembaliModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PengaliranKembaliModel({this.code, this.data, this.message, this.nextPage});
  factory PengaliranKembaliModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PengaliranKembaliModel(
          code: json['code'], message: json['message']);
    } else {
      return PengaliranKembaliModel(
          data: parsedDataPengaliranKembali(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataPengaliranKembali(dataJson) {
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
  String npwpFile;
  String npwpNumb;
  String ktpAddress;
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
      this.ktpAddress,
      this.npwpFile,
      this.npwpNumb,
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
        npwpFile: json['npwp_file'],
        npwpNumb: json['npwp_number'],
        ktpAddress: json['ktp_address'],
        ktpFile: json['ktp_file']);
  }
}

class Biaya {
  Area1 area1;
  Area2 area2;
  Area3 area3;
  Area4 area4;
  Biaya({this.area1, this.area2, this.area3, this.area4});

  factory Biaya.fromJson(Map<String, dynamic> json) {
    return Biaya(
      area1: Area1.fromJson(json['1']),
      area2: Area2.fromJson(json['2']),
      area3: Area3.fromJson(json['3']),
      area4: Area4.fromJson(json['4']),
    );
  }
}

class Area1 {
  String name;
  DataRT dataRT;
  DataPK dataPK;
  Area1({this.name, this.dataPK, this.dataRT});
  factory Area1.fromJson(Map<String, dynamic> json) {
    return Area1(
      name: json['name'],
      dataRT: DataRT.fromJson(json['RT']),
      dataPK: DataPK.fromJson(json['PK']),
      // data: parseData(json['data']),
    );
  }
}

class Area2 {
  String name;
  DataRT dataRT;
  DataPK dataPK;
  Area2({this.name, this.dataPK, this.dataRT});
  factory Area2.fromJson(Map<String, dynamic> json) {
    return Area2(
      name: json['name'],
      dataRT: DataRT.fromJson(json['RT']),
      dataPK: DataPK.fromJson(json['PK']),
    );
  }
}

class Area3 {
  String name;
  DataRT dataRT;
  DataPK dataPK;
  Area3({this.name, this.dataPK, this.dataRT});
  factory Area3.fromJson(Map<String, dynamic> json) {
    return Area3(
      name: json['name'],
      dataRT: DataRT.fromJson(json['RT']),
      dataPK: DataPK.fromJson(json['PK']),
    );
  }
}

class Area4 {
  String name;
  DataRT dataRT;
  DataPK dataPK;
  Area4({this.name, this.dataPK, this.dataRT});
  factory Area4.fromJson(Map<String, dynamic> json) {
    return Area4(
      name: json['name'],
      dataRT: DataRT.fromJson(json['RT']),
      dataPK: DataPK.fromJson(json['PK']),
    );
  }
}

class Data {
  DataRT dataRT;
  DataPK dataPK;

  Data({this.dataPK, this.dataRT});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      dataRT: DataRT.fromJson(json['RT']),
      dataPK: DataPK.fromJson(json['PK']),
    );
  }
}

class DataRT {
  String areaName;
  String type;
  String costCode;
  String currency;
  String cost;
  String taxCost;
  String totalCost;

  DataRT(
      {this.areaName,
      this.cost,
      this.costCode,
      this.currency,
      this.taxCost,
      this.totalCost,
      this.type});
  factory DataRT.fromJson(Map<String, dynamic> json) {
    return DataRT(
      areaName: json['area_name'],
      cost: json['cost'],
      currency: json['currency'],
      costCode: json['cost_code'],
      taxCost: json['tax_cost'],
      type: json['type'],
      totalCost: json['total_cost'],
    );
  }
}

class DataPK {
  String areaName;
  String type;
  String costCode;
  String currency;
  String cost;
  String taxCost;
  String totalCost;

  DataPK(
      {this.areaName,
      this.cost,
      this.costCode,
      this.currency,
      this.taxCost,
      this.totalCost,
      this.type});
  factory DataPK.fromJson(Map<String, dynamic> json) {
    return DataPK(
      areaName: json['area_name'],
      cost: json['cost'],
      currency: json['currency'],
      costCode: json['cost_code'],
      taxCost: json['tax_cost'],
      type: json['type'],
      totalCost: json['total_cost'],
    );
  }
}

class TitleData {
  String customerType;
  String area;
  String cost;

  TitleData({this.area, this.cost, this.customerType});

  factory TitleData.fromJson(Map<String, dynamic> json) {
    return TitleData(
      area: json['area'],
      cost: json['cost'],
      customerType: json['customer_type'],
    );
  }
}
