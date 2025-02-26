class NotificationModel {
  int? unread;
  String? subject;
  Detail? detail;

  NotificationModel({this.unread, this.subject, this.detail});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    unread = json['unread'];
    subject = json['subject'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unread'] = unread;
    data['subject'] = subject;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    return data;
  }
}

class Detail {
  String? title;
  String? agencyName;
  String? eventId;

  Detail({this.title, this.agencyName, this.eventId});

  Detail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    agencyName = json['agencyName'];
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['agencyName'] = agencyName;
    data['eventId'] = eventId;
    return data;
  }
}
