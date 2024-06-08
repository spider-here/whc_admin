class LabTestsModel {
  String id;
  String testName;
  String testType;
  String sampleType;
  String testFor;
  int fee;

  LabTestsModel({required this.id,
    required this.testName,
    required this.testType,
    required this.sampleType,
    required this.testFor,
    required this.fee});

  factory LabTestsModel.fromMap(String id, Map<String, dynamic> data){
    return LabTestsModel(id: id,
        testName: data['name'] ?? 'Unknown',
        testType: data['type'] ?? 'Unknown',
        sampleType: data['sampleType'] ?? 'Unknown',
        testFor: data['testFor'] ?? 'Unknown',
        fee: data['fee'] ?? 0);
  }
}