class Otp {
  String message;
  String status;

  Otp({this.message, this.status});

  factory Otp.fromJson(Map<String, dynamic> json){
    return Otp(
      message: json['message'],
      status: json['status']
    );
  }
}