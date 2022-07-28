/// message : "Notifications Retrieved"
/// status : "Success"
/// notifications : [{"id":"10","title":"Hellu","noti":"\t\t\t\t\t\tHelli","image":"NULL","noti_date":"2022-07-29","created_date":"2022-07-26 05:14:50"},{"id":"7","title":"TI","noti":"Hello Testing Image","image":"1658820571.png","noti_date":"2022-07-13","created_date":"2022-07-26 00:29:29"},{"id":"8","title":"TI 2","noti":"Hello Testing Image","image":"1658820635.png","noti_date":"2022-07-13","created_date":"2022-07-26 00:30:33"},{"id":"9","title":"Test Title","noti":"Hello Message","image":"NULL","noti_date":"2022-07-08","created_date":"2022-07-26 05:14:16"},{"id":"2","title":"Event","noti":"Hello Event","image":null,"noti_date":"0000-00-00","created_date":"2022-07-25 05:21:28"},{"id":"3","title":"New Message","noti":"\t\t\t\t\t\tHello Notifi","image":null,"noti_date":"0000-00-00","created_date":"2022-07-25 05:23:33"},{"id":"4","title":"Testing","noti":"\t\t\t\t\t\thellooo","image":null,"noti_date":"0000-00-00","created_date":"2022-07-25 05:30:06"},{"id":"5","title":"Noti","noti":"Hello Noti Here\t\t\t\t\t\t","image":null,"noti_date":"0000-00-00","created_date":"2022-07-25 23:24:52"},{"id":"6","title":"SB","noti":"\t\t\t\t\t\ttesting notification from snehal batra","image":null,"noti_date":"0000-00-00","created_date":"2022-07-25 23:31:12"}]

class NotificationListResponse {
  NotificationListResponse({
      String? message, 
      String? status, 
      List<Notifications>? notifications,}){
    _message = message;
    _status = status;
    _notifications = notifications;
}

  NotificationListResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<Notifications>? _notifications;

  String? get message => _message;
  String? get status => _status;
  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "10"
/// title : "Hellu"
/// noti : "\t\t\t\t\t\tHelli"
/// image : "NULL"
/// noti_date : "2022-07-29"
/// created_date : "2022-07-26 05:14:50"

class Notifications {
  Notifications({
      String? id, 
      String? title, 
      String? noti, 
      String? image, 
      String? notiDate, 
      String? createdDate,}){
    _id = id;
    _title = title;
    _noti = noti;
    _image = image;
    _notiDate = notiDate;
    _createdDate = createdDate;
}

  Notifications.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _noti = json['noti'];
    _image = json['image'];
    _notiDate = json['noti_date'];
    _createdDate = json['created_date'];
  }
  String? _id;
  String? _title;
  String? _noti;
  String? _image;
  String? _notiDate;
  String? _createdDate;

  String? get id => _id;
  String? get title => _title;
  String? get noti => _noti;
  String? get image => _image;
  String? get notiDate => _notiDate;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['noti'] = _noti;
    map['image'] = _image;
    map['noti_date'] = _notiDate;
    map['created_date'] = _createdDate;
    return map;
  }

}