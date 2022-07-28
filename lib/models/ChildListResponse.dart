/// message : "Children Retrieved"
/// status : "Success"
/// child : [{"ID":"72","HeaderID":"51","Name":"HEER","Image":null,"Mobile":"","DateOfBirth":"0000-00-00","IsMarried":"0","IsRequireJob":"0","Profession":"","Gender":"F"}]

class ChildListResponse {
  ChildListResponse({
      String? message, 
      String? status, 
      List<Child>? child,}){
    _message = message;
    _status = status;
    _child = child;
}

  ChildListResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['child'] != null) {
      _child = [];
      json['child'].forEach((v) {
        _child?.add(Child.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<Child>? _child;

  String? get message => _message;
  String? get status => _status;
  List<Child>? get child => _child;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_child != null) {
      map['child'] = _child?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "72"
/// HeaderID : "51"
/// Name : "HEER"
/// Image : null
/// Mobile : ""
/// DateOfBirth : "0000-00-00"
/// IsMarried : "0"
/// IsRequireJob : "0"
/// Profession : ""
/// Gender : "F"

class Child {
  Child({
      String? id, 
      String? headerID, 
      String? name, 
      dynamic image, 
      String? mobile, 
      String? dateOfBirth, 
      String? isMarried, 
      String? isRequireJob, 
      String? profession, 
      String? gender,}){
    _id = id;
    _headerID = headerID;
    _name = name;
    _image = image;
    _mobile = mobile;
    _dateOfBirth = dateOfBirth;
    _isMarried = isMarried;
    _isRequireJob = isRequireJob;
    _profession = profession;
    _gender = gender;
}

  Child.fromJson(dynamic json) {
    _id = json['ID'];
    _headerID = json['HeaderID'];
    _name = json['Name'];
    _image = json['Image'];
    _mobile = json['Mobile'];
    _dateOfBirth = json['DateOfBirth'];
    _isMarried = json['IsMarried'];
    _isRequireJob = json['IsRequireJob'];
    _profession = json['Profession'];
    _gender = json['Gender'];
  }
  String? _id;
  String? _headerID;
  String? _name;
  dynamic _image;
  String? _mobile;
  String? _dateOfBirth;
  String? _isMarried;
  String? _isRequireJob;
  String? _profession;
  String? _gender;

  String? get id => _id;
  String? get headerID => _headerID;
  String? get name => _name;
  dynamic get image => _image;
  String? get mobile => _mobile;
  String? get dateOfBirth => _dateOfBirth;
  String? get isMarried => _isMarried;
  String? get isRequireJob => _isRequireJob;
  String? get profession => _profession;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['HeaderID'] = _headerID;
    map['Name'] = _name;
    map['Image'] = _image;
    map['Mobile'] = _mobile;
    map['DateOfBirth'] = _dateOfBirth;
    map['IsMarried'] = _isMarried;
    map['IsRequireJob'] = _isRequireJob;
    map['Profession'] = _profession;
    map['Gender'] = _gender;
    return map;
  }

}