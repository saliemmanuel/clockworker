class Feedback {
  int? currentPage;
  List<Data>? data;

  Feedback({this.currentPage, this.data});

  Feedback.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      List<Data> data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? description;
  int? note;
  int? clientId;
  int? prestataireId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.description,
      this.note,
      this.clientId,
      this.prestataireId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    note = json['note'];
    clientId = json['client_id'];
    prestataireId = json['prestataire_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['note'] = this.note;
    data['client_id'] = this.clientId;
    data['prestataire_id'] = this.prestataireId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
