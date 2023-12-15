class ContactsResponseModel {
  bool? success;
  Status? status;
  List<ContactsDataModel>? data;

  ContactsResponseModel({this.success, this.status, this.data});

  ContactsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = <ContactsDataModel>[];
      json['data'].forEach((v) {
        data!.add(new ContactsDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class ContactsDataModel {
  String? id;
  String? shortName;
  String? name;
  String? email;

  ContactsDataModel({this.id, this.name, this.email});

  ContactsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
