class PengembalianPembayaraanModel {
  List<Datas> data;
  String message;
  int code;
  dynamic nextPage;
  PengembalianPembayaraanModel(
      {this.code, this.data, this.message, this.nextPage});
  factory PengembalianPembayaraanModel.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      return PengembalianPembayaraanModel(
          code: json['code'], message: json['message']);
    } else {
      return PengembalianPembayaraanModel(
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
  String createdAt;
  String status;
  String bankName;
  String accountBankName;

  Datas({
    this.id,
    this.createdAt,
    this.idCust,
    this.name,
    this.status,
    this.bankName,
    this.accountBankName,
  });

  factory Datas.fromJson(Map<String, dynamic> json) {
    return Datas(
      id: json['id'],
      status: json['progress_status'],
      idCust: json['customer_id'],
      name: json['customer_name'],
      createdAt: json['created_at'],
      accountBankName: json['account_bank_name'],
      bankName: json['bank_name'],
    );
  }
}

/// MODEL SUCCES CREATE PENGEMBALIAN PEMBAYARAN
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

/// MODEL Get Detail Pengembalian Pembayaran

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
  String sign;
  String status;
  String createdAt;
  String bankName;
  String accountBankName;
  String bankNumb;
  String bankBranch;
  String bankFile;
  String npwpFile;
  String npwpNumb;
  String ktpAddress;
  String fileSuratKuasa;

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
    this.rt,
    this.rw,
    this.sign,
    this.status,
    this.street,
    this.accountBankName,
    this.bankFile,
    this.bankName,
    this.bankNumb,
    this.bankBranch,
    this.ktpAddress,
    this.npwpFile,
    this.npwpNumb,
    this.fileSuratKuasa,
  });
  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      id: json['id'],
      status: json['progress_status'],
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
      accountBankName: json['account_bank_name'],
      bankBranch: json['account_bank_branch'],
      bankFile: json['account_bank_file'],
      bankName: json['bank_name'],
      bankNumb: json['account_bank_number'],
      npwpFile: json['npwp_file'],
      npwpNumb: json['npwp_number'],
      ktpAddress: json['ktp_address'],
    );
  }
}
