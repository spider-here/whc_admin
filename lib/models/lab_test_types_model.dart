class LabTestType {
  final String title;
  final String icon;
  final String type;
  const LabTestType(
      {required this.title, required this.icon, required this.type});
}

const List<LabTestType> labTestTypes = <LabTestType>[
  LabTestType(
      title: 'Diabetes',
      icon: 'assets/icons/labTest/diabetes.png',
      type: 'diabetes'),
  LabTestType(
      title: 'Heart',
      icon: 'assets/icons/labTest/heart.png',
      type: 'heart'),
  LabTestType(
      title: 'Blood',
      icon: 'assets/icons/labTest/blood.png',
      type: 'blood'),
  LabTestType(
      title: 'Liver',
      icon: 'assets/icons/labTest/liver.png',
      type: 'liver'),
  LabTestType(
      title: 'Kidney',
      icon: 'assets/icons/labTest/kidney.png',
      type: 'kidney'),
  LabTestType(
      title: 'Thyroid',
      icon: 'assets/icons/labTest/thyroid.png',
      type: 'thyroid'),
  LabTestType(
      title: 'Digestive System',
      icon: 'assets/icons/labTest/stomach.png',
      type: 'digestiveSystem'),
  LabTestType(
      title: 'Infectious Diseases',
      icon: 'assets/icons/labTest/infection.png',
      type: 'infectiousDisease'),
  LabTestType(
      title: 'Allergy',
      icon: 'assets/icons/labTest/allergy.png',
      type: 'allergy'),
  LabTestType(
      title: 'Hormone',
      icon: 'assets/icons/labTest/hormone.png',
      type: 'hormone'),
  LabTestType(
      title: 'Female Specific',
      icon: 'assets/icons/labTest/female.png',
      type: 'femaleSpecific'),
  LabTestType(
      title: 'Male specific',
      icon: 'assets/icons/labTest/male.png',
      type: 'maleSpecific'),
  LabTestType(
      title: 'Mineral Deficiency',
      icon: 'assets/icons/labTest/minerals.png',
      type: 'mineralDeficiency'),
  LabTestType(
      title: 'Basic Wellness',
      icon: 'assets/icons/labTest/health.png',
      type: 'basicWellness'),
  LabTestType(
      title: 'Immunology',
      icon: 'assets/icons/labTest/immunology.png',
      type: 'immunology'),
  LabTestType(
      title: 'Drug & Alcohol',
      icon: 'assets/icons/labTest/drugs.png',
      type: 'drugs'),
];
