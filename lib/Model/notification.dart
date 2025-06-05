class NotificationApp {
  String? uuid;
  String? title;
  String? body;
  String? data;
  String? createdAt;
  int? isRead;

  NotificationApp(
      {this.uuid,
      this.title,
      this.body,
      this.data,
      this.createdAt,
      this.isRead});

  NotificationApp.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    body = json['body'];
    data = json['data'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['title'] = title;
    data['body'] = body;
    data['data'] = this.data;
    data['created_at'] = createdAt;
    data['is_read'] = isRead;
    return data;
  }
}
