
class Smartwatch {

  int id;
  int smartphoneId;
  String childName;
  double currentLat;
  double currentLong;
  double referenceLat;
  double referenceLong;
  int maxRadio;
  String token;

  Smartwatch({
    required this.id,
    required this.smartphoneId,
    required this.childName,
    required this.currentLat,
    required this.currentLong,
    required this.referenceLat,
    required this.referenceLong,
    required this.maxRadio,
    required this.token
  });

  static Smartwatch fromJson(Map<String, dynamic> map) {
    return Smartwatch(
      id: map["id"], 
      smartphoneId: map["smartphoneId"], 
      childName: map["childName"], 
      currentLat: map["currentLat"], 
      currentLong: map["currentLong"], 
      referenceLat: map["referenceLat"], 
      referenceLong: map["referenceLong"], 
      maxRadio: map["maxRadio"], 
      token: map["token"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "smartphoneId": smartphoneId,
      "childName": childName,
      "currentLat": currentLat, 
      "currentLong": currentLong,
      "referenceLat": referenceLat,
      "referenceLong": referenceLong,
      "maxRadio": maxRadio,
      "token": token,
    };
  }

}
