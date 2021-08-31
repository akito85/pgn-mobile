// class GetCustBillDetail {
//   List<DatasInvoiceCust> data;

//   GetCustBillDetail({this.data});

//   factory GetCustBillDetail.fromJson(Map<String, dynamic> json){
//     return GetCustBillDetail(
//       data: parseDataInvoiceCust(json['data']),
//     );
//   }

//   static List<DatasInvoiceCust> parseDataInvoiceCust(datasJson){
//     var list = datasJson as List;
//     List<DatasInvoiceCust> datasInvoiceCust =
//     list.map((data) => DatasInvoiceCust.fromJson(data)).toList();
//     return datasInvoiceCust;
//   }
// }

// class DatasInvoiceCust {
//   String id;
//   String custId;
//   String custName;
//   InvoicePeriod invoicePeriod;
//   CountedEnergy countedEnergy;
// }