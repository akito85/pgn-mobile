class CMMFormModel {
  String message;
  bool response;

  CMMFormModel({this.message, this.response});

  factory CMMFormModel.fromJson(Map<String, dynamic> json) {
    return CMMFormModel(
      message: json['message'],
      response: json['response'],
    );
  }
}
