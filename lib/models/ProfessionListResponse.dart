/// message : "Professions Retrieved"
/// status : "Success"
/// professions : [{"ID":"4","Name":"Accountant"},{"ID":"14","Name":"BusinessMan"},{"ID":"1","Name":"CA"},{"ID":"11","Name":"Computer Operator"},{"ID":"3","Name":"Doctor"},{"ID":"2","Name":"Engineer"},{"ID":"10","Name":"HR"},{"ID":"16","Name":"JOB"},{"ID":"12","Name":"Laborer"},{"ID":"13","Name":"Other"},{"ID":"9","Name":"Receptionist"},{"ID":"6","Name":"Salesman"},{"ID":"7","Name":"Service Executive"},{"ID":"5","Name":"Software Developer"},{"ID":"15","Name":"Study"},{"ID":"8","Name":"TeleCaller"}]

class ProfessionListResponse {
  ProfessionListResponse({
      String? message, 
      String? status, 
      List<Professions>? professions,}){
    _message = message;
    _status = status;
    _professions = professions;
}

  ProfessionListResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['professions'] != null) {
      _professions = [];
      json['professions'].forEach((v) {
        _professions?.add(Professions.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<Professions>? _professions;

  String? get message => _message;
  String? get status => _status;
  List<Professions>? get professions => _professions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_professions != null) {
      map['professions'] = _professions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "4"
/// Name : "Accountant"

class Professions {
  Professions({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Professions.fromJson(dynamic json) {
    _id = json['ID'];
    _name = json['Name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['Name'] = _name;
    return map;
  }

}