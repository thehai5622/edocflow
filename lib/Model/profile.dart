class Profile {
  String? uuid;
  String? name;
  String? avatar;
  int? gender;
  String? birthDay;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  IssuingAuthority? issuingAuthority;
  Permission? permission;

  Profile(
      {this.uuid,
      this.name,
      this.avatar,
      this.gender,
      this.birthDay,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.issuingAuthority,
      this.permission});

  Profile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    avatar = json['avatar'];
    gender = json['gender'];
    birthDay = json['birth_day'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    issuingAuthority = json['issuing_authority'] != null
        ? IssuingAuthority.fromJson(json['issuing_authority'])
        : null;
    permission = json['permission'] != null
        ? Permission.fromJson(json['permission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['birth_day'] = birthDay;
    data['phone'] = phone;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (issuingAuthority != null) {
      data['issuing_authority'] = issuingAuthority!.toJson();
    }
    if (permission != null) {
      data['permission'] = permission!.toJson();
    }
    return data;
  }
}

class IssuingAuthority {
  String? uuid;
  String? name;

  IssuingAuthority({this.uuid, this.name});

  IssuingAuthority.fromJson(Map<String, dynamic> json) {
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

class Permission {
  int? uuid;
  String? name;

  Permission({this.uuid, this.name});

  Permission.fromJson(Map<String, dynamic> json) {
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
