class Dashboard {
  DocumentOut? documentOut;
  DocumentOut? documentIn;

  Dashboard({this.documentOut, this.documentIn});

  Dashboard.fromJson(Map<String, dynamic> json) {
    documentOut = json['document_out'] != null
        ? DocumentOut.fromJson(json['document_out'])
        : null;
    documentIn = json['document_in'] != null
        ? DocumentOut.fromJson(json['document_in'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (documentOut != null) {
      data['document_out'] = documentOut!.toJson();
    }
    if (documentIn != null) {
      data['document_in'] = documentIn!.toJson();
    }
    return data;
  }
}

class DocumentOut {
  int? total;
  int? unprocessed;
  int? pendingApproval;
  int? pendingRelease;
  int? active;
  int? overdue;
  int? canceled;

  DocumentOut(
      {this.total,
      this.unprocessed,
      this.pendingApproval,
      this.pendingRelease,
      this.active,
      this.overdue,
      this.canceled});

  DocumentOut.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    unprocessed = json['unprocessed'];
    pendingApproval = json['pending_approval'];
    pendingRelease = json['pending_release'];
    active = json['active'];
    overdue = json['overdue'];
    canceled = json['canceled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['unprocessed'] = unprocessed;
    data['pending_approval'] = pendingApproval;
    data['pending_release'] = pendingRelease;
    data['active'] = active;
    data['overdue'] = overdue;
    data['canceled'] = canceled;
    return data;
  }
}

extension DocumentOutExt on DocumentOut {
  Map<String, int> toStatusMap() {
    return {
      'unprocessed': unprocessed ?? 0,
      'pending_approval': pendingApproval ?? 0,
      'pending_release': pendingRelease ?? 0,
      'active': active ?? 0,
      'overdue': overdue ?? 0,
      'canceled': canceled ?? 0,
    };
  }
}
