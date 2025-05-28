class User {
  String? uuid;
  String? name;
  int? gender;
  String? birthDay;
  String? phone;
  String? email;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? avatar;
  int? status;
  Permission? permission;
  IssuingAuthority? issuingAuthority;

  User(
      {this.uuid,
      this.name,
      this.gender,
      this.birthDay,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.avatar,
      this.status,
      this.permission,
      this.issuingAuthority});

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    gender = json['gender'];
    birthDay = json['birth_day'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    status = json['status'];
    permission = json['permission'] != null
        ? Permission.fromJson(json['permission'])
        : null;
    issuingAuthority = json['issuing_authority'] != null
        ? IssuingAuthority.fromJson(json['issuing_authority'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['gender'] = gender;
    data['birth_day'] = birthDay;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['avatar'] = avatar;
    data['status'] = status;
    if (permission != null) {
      data['permission'] = permission!.toJson();
    }
    if (issuingAuthority != null) {
      data['issuing_authority'] = issuingAuthority!.toJson();
    }
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
