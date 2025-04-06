class MetaResponse {
  final int? status;
  final String? message;
  final bool? error;

  MetaResponse({this.status, this.message, this.error});
  factory MetaResponse.fromJson(Map<String, dynamic> json) {
    return MetaResponse(
      status: json['status'],
      message: json['message'],
      error: json['error'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'error': error};
  }
}
