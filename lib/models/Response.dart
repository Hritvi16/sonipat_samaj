
class Response {
  Response({
    String? message,
    String? status}){
    _message = message;
    _status = status;
  }

  Response.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
  }
  String? _message;
  String? _status;

  String? get message => _message;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }

}