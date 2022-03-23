class Prestataire {
  List<Data>? data;

  Prestataire({this.data});

  Prestataire.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      List<Data> data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? password;
  String? status;
  String? phone;
  String? picture;
  String? isactive;
  int? villeId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.status,
      this.phone,
      this.picture,
      this.isactive,
      this.villeId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    phone = json['phone'];
    picture = json['picture'];
    isactive = json['isactive'];
    villeId = json['ville_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['isactive'] = this.isactive;
    data['ville_id'] = this.villeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
