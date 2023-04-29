import 'dart:convert';

List<MongoData> MongoDataFromJson(String str) =>
    List<MongoData>.from(json.decode(str).map((x) => MongoData.fromJson(x)));

String MongoDataToJson(List<MongoData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MongoData {
  MongoData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
  });

  Object id;
  String firstname;
  String lastname;
  String email;
  String phone;

  factory MongoData.fromJson(Map<String, dynamic> json) => MongoData(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
      };
}
