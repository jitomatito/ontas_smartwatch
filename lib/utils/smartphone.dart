
class Smartphone {

  int id;
  String phoneNumber;            

  Smartphone({
    required this.id,
    required this.phoneNumber
  });

  static Smartphone fromJson(Map<String, dynamic> map) {
    return Smartphone(
      id: map["id"], 
      phoneNumber: map["phoneNumber"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "phoneNumber": phoneNumber
    };
  }

}