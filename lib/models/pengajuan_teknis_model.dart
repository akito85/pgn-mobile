class PengajuanTeknisModel {
  List<Datas> data;
  String message;
  int code;
  // Paging paging;
  dynamic nextPage;
  PengajuanTeknisModel({this.code, this.data, this.message, this.nextPage});
  factory PengajuanTeknisModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PengajuanTeknisModel(code: json['code'], message: json['message']);
    } else {
      return PengajuanTeknisModel(
          data: parsedDataPengajuanTeknis(json['data']),
          nextPage: json['next_page_url']);
    }
  }

  static List<Datas> parsedDataPengajuanTeknis(dataJson) {
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
  String techType;

  Datas(
      {this.id,
      this.createdAt,
      this.idCust,
      this.name,
      this.reason,
      this.status,
      this.subDate,
      this.techType});

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
        id: json['id'],
        subDate: json['submission_date'],
        status: json['progress_status'],
        reason: json['reason'],
        idCust: json['customer_id'],
        name: json['customer_name'],
        createdAt: json['created_at'],
        techType: json['technical_type']);
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
  dynamic techId;
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
  String techTye;
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
      this.techTye,
      this.ktpAddress,
      this.npwpFile,
      this.npwpNumb,
      this.techId,
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
      techTye: json['technical_type'],
      npwpFile: json['npwp_file'],
      npwpNumb: json['npwp_number'],
      ktpAddress: json['ktp_address'],
      techId: json['technical_type_id'],
      ktpFile: json['ktp_file'],
    );
  }
}

// GET TECH TYPE

class GetTechTypes {
  List<DataTechType> data;

  GetTechTypes({this.data});

  factory GetTechTypes.fromJson(Map<String, dynamic> json) {
    return GetTechTypes(
      data: parseDataTechType(json['data']),
    );
  }

  static List<DataTechType> parseDataTechType(datasJson) {
    var list = datasJson as List;
    List<DataTechType> datasProvinces =
        list.map((data) => DataTechType.fromJson(data)).toList();
    return datasProvinces;
  }
}

class DataTechType {
  String name;
  DataTechType({this.name});

  factory DataTechType.fromJson(Map<String, dynamic> json) {
    return DataTechType(name: json['name']);
  }
}

class Biaya {
  List<TitleData> titleData;
  Biaya({this.titleData});

  factory Biaya.fromJson(Map<String, dynamic> json) {
    return Biaya(
      titleData: parseDataTitle(json['G.1.6']),
    );
  }

  static List<TitleData> parseDataTitle(datasJson) {
    var list = datasJson as List;
    List<TitleData> datasTitle =
        list.map((data) => TitleData.fromJson(data)).toList();
    return datasTitle;
  }
}

class TitleData {
  String meterType;
  String area;
  String cost;

  TitleData({this.area, this.cost, this.meterType});

  factory TitleData.fromJson(Map<String, dynamic> json) {
    return TitleData(
      area: json['area'],
      cost: json['cost'],
      meterType: json['meter_type'],
    );
  }
}

class PengajuanTeknisTypeModel {
  List<DataType> data;
  String message;
  int code;
  PengajuanTeknisTypeModel({this.code, this.data, this.message});
  factory PengajuanTeknisTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PengajuanTeknisTypeModel(
          code: json['code'], message: json['message']);
    } else {
      return PengajuanTeknisTypeModel(
        data: parsedDataPengajuanTeknisType(json['data']),
      );
    }
  }

  static List<DataType> parsedDataPengajuanTeknisType(dataJson) {
    var list = dataJson as List;
    List<DataType> datas = list.map((data) => DataType.fromJson(data)).toList();
    return datas;
  }
}

class DataType {
  int id;
  String name;

  DataType({this.id, this.name});

  factory DataType.fromJson(Map<String, dynamic> json) {
    return DataType(
      id: json['id'],
      name: json['name'],
    );
  }
}
