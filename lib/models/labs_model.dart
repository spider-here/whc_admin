
class LabsModel {
  String id;
  String labName;
  String address;
  int phoneNumber;

  LabsModel(
      {required this.id,
      required this.labName,
      required this.address,
      required this.phoneNumber});

  factory LabsModel.fromMap(String id, Map<String, dynamic> data) {
    return LabsModel(
        id: id,
        labName: data['name'] ?? 'Unknown',
        address: data['address'] ?? 'Unknown',
        phoneNumber: data['phoneNumber']);
  }
}
