import 'package:collection/collection.dart';

class CustomLocationsManager {
  static List<CustomLocation> customLocations = [];

  static List<CustomLocation> fetchAll({required bool sortByNewest}) {
    if (sortByNewest) {
      return customLocations;
    } else {
      return new List.from(customLocations.reversed);
    }
  }

  static CustomLocation? fetchByUUID(String uuid) {
    CustomLocation? ret = customLocations
        .firstWhereOrNull((element) => element.getUUID() == uuid);
    return ret;
  }

  static RemoveByUUID(String uuid) {
    customLocations.removeWhere((element) => element.getUUID() == uuid);
  }
}

class CustomLocation {
  late final String _uuid;
  late String _locality = "";
  late String _subAdministrativeArea = "";
  late String _street = "";
  // ignore: non_constant_identifier_names
  late String _ISOCountry = ""; // 2 letter code
  late String _timestamp = ""; // ex: 2021-10-25T21:25:08.210Z
  late String _activity = "";
  late num _speed = -1; //in meters / second
  late num _speedAccuracy = -1; //in meters / second
  late num _altitude = -1; //in meters
  late num _altitudeAccuracy = -1; // in meters

  /// Makes timestamp readable by a human
  String formatTimestamp(String timestamp) {
    //2021-10-25T21:25:08.210Z <- This is the original format
    //2021-10-25 | 21:25:08    <- This is the result
    String result = "";
    for (int i = 0; i < timestamp.length; ++i) {
      if (timestamp[i] != "T" && timestamp[i] != ".")
        result += timestamp[i];
      else if (timestamp[i] == "T")
        result += " | ";
      else if (timestamp[i] == ".") break;
    }
    return result;
  }

  /// Checks if data is valid and then displays 3 lines with: Activity, Speed and Altitude
  String displayCustomText(num maxSpeedAccuracy, num maxAltitudeAccuracy) {
    String ret = "";

    ret += " \nActivity: " + _activity;

    /// Speed has to be both valid and accurate
    if (_speed != -1 && _speedAccuracy != -1) {
      if (_speedAccuracy <= maxSpeedAccuracy)
        ret += " \nSpeed: " + _speed.toString() + " m/s";
    }
    if (_altitudeAccuracy <= maxAltitudeAccuracy)
      ret += "\nAltitude: " + _altitude.toString() + " m";

    return ret;
  }

  // Variable setters
  void setUUID(String uuid) {
    _uuid = uuid;
  }

  void setLocality(String locality) {
    _locality = locality;
  }

  void setSubAdministrativeArea(String subAdminArea) {
    _subAdministrativeArea = subAdminArea;
  }

  void setStreet(String street) {
    _street = street;
  }

  void setISOCountry(String iso) {
    _ISOCountry = iso;
  }

  void setTimestamp(String timestamp) {
    _timestamp = formatTimestamp(timestamp);
  }

  void setActivity(String activity) {
    _activity = activity;
  }

  void setSpeed(num speed, num speedAcc) {
    _speed = speed;
    _speedAccuracy = speedAcc;
  }

  void setAltitude(num altitude, num altitudeAcc) {
    _altitude = altitude;
    _altitudeAccuracy = altitudeAcc;
  }

  // Variable getters
  String getUUID() {
    return _uuid;
  }

  String getLocality() {
    return _locality;
  }

  String getSubAdministrativeArea() {
    return _subAdministrativeArea;
  }

  String getStreet() {
    return _street;
  }

  String getISOCountryCode() {
    return _ISOCountry;
  }

  String getTimestamp() {
    return _timestamp;
  }

  String getActivity() {
    return _activity;
  }

  num getSpeed() {
    return _speed;
  }

  num getSpeedAcc() {
    return _speedAccuracy;
  }

  num getAltitude() {
    return _altitude;
  }

  num getAltitudeAcc() {
    return _altitude;
  }
}
