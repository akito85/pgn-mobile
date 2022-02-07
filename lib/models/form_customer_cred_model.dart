class FormCustomerCredModel {
  List<CustProfileDataOutput> custProfileDataOutput;

  FormCustomerCredModel({this.custProfileDataOutput});

  factory FormCustomerCredModel.fromJson(Map<String, dynamic> json) {
    return FormCustomerCredModel(
      custProfileDataOutput:
          parsedDataCustProfile(json['CustProfileDataOutput']),
    );
  }

  static List<CustProfileDataOutput> parsedDataCustProfile(dataJson) {
    var list = dataJson as List;
    List<CustProfileDataOutput> dataCustProfile =
        list.map((data) => CustProfileDataOutput.fromJson(data)).toList();
    return dataCustProfile;
  }
}

class CustProfileDataOutput {
  String nik;
  String addressMeter;
  String kelurahan;
  String kecamatan;
  String kota;
  String addressNpwpKtp;

  CustProfileDataOutput(
      {this.addressMeter,
      this.addressNpwpKtp,
      this.kecamatan,
      this.kelurahan,
      this.kota,
      this.nik});

  factory CustProfileDataOutput.fromJson(Map<String, dynamic> json) {
    return CustProfileDataOutput(
        nik: json['NIK'],
        addressMeter: json['ADDRESS_METER'],
        kelurahan: json['KELURAHAN'],
        kecamatan: json['KECAMATAN'],
        kota: json['KOTA'],
        addressNpwpKtp: json['ADDRESS_NPWP_NIK']);
  }
}
