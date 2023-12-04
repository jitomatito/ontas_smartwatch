
class Smartwatch {

  int id;
  int smartphoneId;
  String? childName;
  double? currentLat;
  double? currentLong;
  double? referenceLat;
  double? referenceLong;
  int? maxDistanceRadio;
  String token;
  bool active;

  Smartwatch({
    required this.id,
    required this.smartphoneId,
    required this.childName,
    required this.currentLat,
    required this.currentLong,
    required this.referenceLat,
    required this.referenceLong,
    required this.maxDistanceRadio,
    required this.token,
    required this.active
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
      maxDistanceRadio: map["maxDistanceRadio"], 
      token: map["token"],
      active: map["active"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //"id": id,
      //"smartphoneId": smartphoneId,
      "childName": childName,
      "currentLat": currentLat, 
      "currentLong": currentLong,
      "referenceLat": referenceLat,
      "referenceLong": referenceLong,
      "maxDistanceRadio": maxDistanceRadio,
      "token": token,
      "active": active
    };
  }

}
