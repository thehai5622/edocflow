class Profile {
  String? uuid;
  String? name;
  String? avatar;
  int? gender;
  String? birthDay;
  String? phone;
  String? email;
  int? permissionId;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.uuid,
      this.name,
      this.avatar,
      this.gender,
      this.birthDay,
      this.phone,
      this.email,
      this.permissionId,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    avatar = json['avatar'];
    gender = json['gender'];
    birthDay = json['birth_day'];
    phone = json['phone'];
    email = json['email'];
    permissionId = json['permission_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['permission_id'] = permissionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
