class TemplateFile {
  String? uuid;
  String? name;
  String? file;
  int? type;
  int? status;
  String? note;
  String? createdAt;
  String? updatedAt;
  User? user;
  User? typeTemplateFile;

  TemplateFile(
      {this.uuid,
      this.name,
      this.file,
      this.type,
      this.status,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.typeTemplateFile});

  TemplateFile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    file = json['file'];
    type = json['type'];
    status = json['status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    typeTemplateFile = json['type_template_file'] != null
        ? User.fromJson(json['type_template_file'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['file'] = file;
    data['type'] = type;
    data['status'] = status;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (typeTemplateFile != null) {
      data['type_template_file'] = typeTemplateFile!.toJson();
    }
    return data;
  }
}

class User {
  String? uuid;
  String? name;

  User({this.uuid, this.name});

  User.fromJson(Map<String, dynamic> json) {
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
