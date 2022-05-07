class AddressModel {
  late int? _id;
  late String _addressType;
  late String _contactPersonName;
  late String _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
  }) {
    _id = id;
    _address = address;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _longitude = longitude;
    _latitude = latitude;
  }

  int get id => _id ?? -1;
  String get addressType => _addressType;
  String get contactPersonName => _contactPersonName;
  String get contactPersonNumber => _contactPersonNumber;
  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> jsonData) {
    _id = jsonData['id'];
    _addressType = jsonData['address_type'] ?? "";
    _contactPersonName = jsonData['contact_person_name'] ?? "";
    _contactPersonNumber = jsonData['contact_person_number'] ?? "";
    _address = jsonData['address'];
    _latitude = jsonData['latitude'];
    _longitude = jsonData['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['address_type'] = _addressType;
    data['address'] = _address;
    data['contact_person_name'] = _contactPersonName;
    data['contact_person_number'] = _contactPersonNumber;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;

    return data;
  }
}
