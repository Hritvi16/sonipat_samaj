/// message : "Events Retrieved"
/// status : "Success"
/// events : [{"id":"4","event_name":"Event1","event_description":"&lt;p&gt;Hellooo Event 1&lt;/p&gt;\r\n","event_image":"event1.jpg","event_date":"2022-07-16","end_date":"2022-07-11"}]

class EventListResponse {
  EventListResponse({
      String? message, 
      String? status, 
      List<Events>? events,}){
    _message = message;
    _status = status;
    _events = events;
}

  EventListResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<Events>? _events;

  String? get message => _message;
  String? get status => _status;
  List<Events>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "4"
/// event_name : "Event1"
/// event_description : "&lt;p&gt;Hellooo Event 1&lt;/p&gt;\r\n"
/// event_image : "event1.jpg"
/// event_date : "2022-07-16"
/// end_date : "2022-07-11"

class Events {
  Events({
      String? id, 
      String? eventName, 
      String? eventDescription, 
      String? eventImage, 
      String? eventDate, 
      String? endDate,}){
    _id = id;
    _eventName = eventName;
    _eventDescription = eventDescription;
    _eventImage = eventImage;
    _eventDate = eventDate;
    _endDate = endDate;
}

  Events.fromJson(dynamic json) {
    _id = json['id'];
    _eventName = json['event_name'];
    _eventDescription = json['event_description'];
    _eventImage = json['event_image'];
    _eventDate = json['event_date'];
    _endDate = json['end_date'];
  }
  String? _id;
  String? _eventName;
  String? _eventDescription;
  String? _eventImage;
  String? _eventDate;
  String? _endDate;

  String? get id => _id;
  String? get eventName => _eventName;
  String? get eventDescription => _eventDescription;
  String? get eventImage => _eventImage;
  String? get eventDate => _eventDate;
  String? get endDate => _endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['event_name'] = _eventName;
    map['event_description'] = _eventDescription;
    map['event_image'] = _eventImage;
    map['event_date'] = _eventDate;
    map['end_date'] = _endDate;
    return map;
  }

}