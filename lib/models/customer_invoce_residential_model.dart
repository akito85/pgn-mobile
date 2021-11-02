class CustomerInvoiceResidential {
  List<DataCustInvoiceResidential> data;
  String message;
  CustomerInvoiceResidential({this.data, this.message});

  factory CustomerInvoiceResidential.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null)
      return CustomerInvoiceResidential(
        data: parseDataInvoiceResidential(json['data']),
      );
    else
      return CustomerInvoiceResidential(message: json['message']);
  }

  static List<DataCustInvoiceResidential> parseDataInvoiceResidential(
      datasJson) {
    var list = datasJson as List;
    List<DataCustInvoiceResidential> datasInvoice =
        list.map((data) => DataCustInvoiceResidential.fromJson(data)).toList();
    return datasInvoice;
  }
}

class DataCustInvoiceResidential {
  String invoiceId;
  String custInvoiceId;
  String custInvoiceName;
  String custVolUsage;
  String tBillIdr;
  String pGuaranteeIdr;
  String pGuaranteeUsd;
  String arrersIdr;
  String arrersUsd;
  int isPaid;
  String usagePeriod;
  String invoicePeriod;
  String custInvoicePeriod;
  String type;
  String denda;
  String biayaPengaliran;
  String biayaPemasangan;
  String biayaMigrasi;
  String biayaPelayanan;
  String biayaSms;

  DataCustInvoiceResidential(
      {this.arrersIdr,
      this.arrersUsd,
      this.custInvoiceId,
      this.custInvoiceName,
      this.custInvoicePeriod,
      this.custVolUsage,
      this.invoiceId,
      this.invoicePeriod,
      this.isPaid,
      this.pGuaranteeIdr,
      this.pGuaranteeUsd,
      this.tBillIdr,
      this.type,
      this.usagePeriod,
      this.biayaMigrasi,
      this.biayaPelayanan,
      this.biayaPemasangan,
      this.biayaPengaliran,
      this.biayaSms,
      this.denda});

  factory DataCustInvoiceResidential.fromJson(Map<String, dynamic> json) {
    return DataCustInvoiceResidential(
        invoiceId: json['id'],
        custInvoiceId: json['customer_id'],
        custInvoiceName: json['customer_name'],
        custVolUsage: json['volume_usage'],
        tBillIdr: json['total_bill_idr'],
        pGuaranteeIdr: json['payment_guarantee_idr'],
        pGuaranteeUsd: json['payment_guarantee_usd'],
        arrersIdr: json['arrears_idr'],
        arrersUsd: json['arrears_usd'],
        isPaid: json['is_paid'],
        invoicePeriod: json['invoice_period'],
        usagePeriod: json['usage_period'],
        custInvoicePeriod: json['custom_invoice_period'],
        type: json['type'],
        denda: json['denda'],
        biayaPengaliran: json['biaya_pengaliran_kembali'],
        biayaPelayanan: json['biaya_pelayanan'],
        biayaPemasangan: json['biaya_pemasangan_kembali'],
        biayaMigrasi: json['biaya_migrasi'],
        biayaSms: json['biasa_sms']);
  }
}
