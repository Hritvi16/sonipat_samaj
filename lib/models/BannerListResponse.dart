/// message : "Banners Retrieved"
/// status : "Success"
/// banners : [{"ID":"8","Name":"1","Location":"1.jpeg","isRuPayBanner":"0","Ordinal":"1"},{"ID":"9","Name":"2","Location":"2.jpeg","isRuPayBanner":"0","Ordinal":"2"},{"ID":"10","Name":"3","Location":"3.jpeg","isRuPayBanner":"0","Ordinal":"3"},{"ID":"11","Name":"4","Location":"4.jpeg","isRuPayBanner":"0","Ordinal":"4"},{"ID":"12","Name":"5","Location":"5.jpeg","isRuPayBanner":"0","Ordinal":"5"},{"ID":"13","Name":"6","Location":"6.jpeg","isRuPayBanner":"0","Ordinal":"6"},{"ID":"14","Name":"7","Location":"7.jpeg","isRuPayBanner":"0","Ordinal":"7"},{"ID":"15","Name":"8","Location":"8.jpeg","isRuPayBanner":"0","Ordinal":"8"},{"ID":"16","Name":"9","Location":"9.jpeg","isRuPayBanner":"0","Ordinal":"9"},{"ID":"17","Name":"10","Location":"10.jpeg","isRuPayBanner":"0","Ordinal":"10"},{"ID":"18","Name":"11","Location":"11.jpeg","isRuPayBanner":"0","Ordinal":"11"},{"ID":"19","Name":"12","Location":"12.jpeg","isRuPayBanner":"0","Ordinal":"12"},{"ID":"20","Name":"13","Location":"13.jpeg","isRuPayBanner":"0","Ordinal":"13"},{"ID":"24","Name":"14","Location":"14.jpeg","isRuPayBanner":"0","Ordinal":"14"},{"ID":"21","Name":"15","Location":"15.jpeg","isRuPayBanner":"0","Ordinal":"15"},{"ID":"22","Name":"16","Location":"16.jpeg","isRuPayBanner":"0","Ordinal":"16"},{"ID":"23","Name":"17","Location":"17.jpeg","isRuPayBanner":"0","Ordinal":"17"}]

class BannerListResponse {
  BannerListResponse({
      String? message, 
      String? status, 
      List<Banners>? banners,}){
    _message = message;
    _status = status;
    _banners = banners;
}

  BannerListResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<Banners>? _banners;

  String? get message => _message;
  String? get status => _status;
  List<Banners>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ID : "8"
/// Name : "1"
/// Location : "1.jpeg"
/// isRuPayBanner : "0"
/// Ordinal : "1"

class Banners {
  Banners({
      String? id, 
      String? name, 
      String? location, 
      String? isRuPayBanner, 
      String? ordinal,}){
    _id = id;
    _name = name;
    _location = location;
    _isRuPayBanner = isRuPayBanner;
    _ordinal = ordinal;
}

  Banners.fromJson(dynamic json) {
    _id = json['ID'];
    _name = json['Name'];
    _location = json['Location'];
    _isRuPayBanner = json['isRuPayBanner'];
    _ordinal = json['Ordinal'];
  }
  String? _id;
  String? _name;
  String? _location;
  String? _isRuPayBanner;
  String? _ordinal;

  String? get id => _id;
  String? get name => _name;
  String? get location => _location;
  String? get isRuPayBanner => _isRuPayBanner;
  String? get ordinal => _ordinal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['Name'] = _name;
    map['Location'] = _location;
    map['isRuPayBanner'] = _isRuPayBanner;
    map['Ordinal'] = _ordinal;
    return map;
  }

}