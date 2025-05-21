class Document {
  String? uuid;
  String? summary;
  int? year;
  String? originalLocation;
  int? numberReleases;
  int? status;
  int? urgencyLevel;
  int? confidentialityLevel;
  String? createdAt;
  String? updatedAt;
  User? user;
  User? usersign;
  User? fromIssuingauthority;
  User? issuingauthority;
  User? field;
  User? templatefile;

  Document(
      {this.uuid,
      this.summary,
      this.year,
      this.originalLocation,
      this.numberReleases,
      this.status,
      this.urgencyLevel,
      this.confidentialityLevel,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.usersign,
      this.fromIssuingauthority,
      this.issuingauthority,
      this.field,
      this.templatefile});

  Document.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    summary = json['summary'];
    year = json['year'];
    originalLocation = json['original_location'];
    numberReleases = json['number_releases'];
    status = json['status'];
    urgencyLevel = json['urgency_level'];
    confidentialityLevel = json['confidentiality_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    usersign = json['usersign'] != null
        ? User.fromJson(json['usersign'])
        : null;
    fromIssuingauthority = json['from_issuingauthority'] != null
        ? User.fromJson(json['from_issuingauthority'])
        : null;
    issuingauthority = json['issuingauthority'] != null
        ? User.fromJson(json['issuingauthority'])
        : null;
    field = json['field'] != null ? User.fromJson(json['field']) : null;
    templatefile = json['templatefile'] != null
        ? User.fromJson(json['templatefile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['summary'] = summary;
    data['year'] = year;
    data['original_location'] = originalLocation;
    data['number_releases'] = numberReleases;
    data['status'] = status;
    data['urgency_level'] = urgencyLevel;
    data['confidentiality_level'] = confidentialityLevel;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (usersign != null) {
      data['usersign'] = usersign!.toJson();
    }
    if (fromIssuingauthority != null) {
      data['from_issuingauthority'] = fromIssuingauthority!.toJson();
    }
    if (issuingauthority != null) {
      data['issuingauthority'] = issuingauthority!.toJson();
    }
    if (field != null) {
      data['field'] = field!.toJson();
    }
    if (templatefile != null) {
      data['templatefile'] = templatefile!.toJson();
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
