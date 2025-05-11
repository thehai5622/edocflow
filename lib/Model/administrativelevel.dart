class AdministrativeLevel {
  int? uuid;
  String? name;
  String? createdAt;
  String? updatedAt;

  AdministrativeLevel({this.uuid, this.name, this.createdAt, this.updatedAt});

  AdministrativeLevel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
