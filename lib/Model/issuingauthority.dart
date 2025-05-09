class IssuingAuthority {
  String? uuid;
  String? name;
  String? createdAt;
  String? updatedAt;
  AdministrativeLevel? administrativeLevel;

  IssuingAuthority(
      {this.uuid,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.administrativeLevel});

  IssuingAuthority.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    administrativeLevel = json['administrative_level'] != null
        ? AdministrativeLevel.fromJson(json['administrative_level'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = uuid;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (administrativeLevel != null) {
      data['administrative_level'] = administrativeLevel!.toJson();
    }
    return data;
  }
}

class AdministrativeLevel {
  int? uuid;
  String? name;

  AdministrativeLevel({this.uuid, this.name});

  AdministrativeLevel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    return data;
  }
}
