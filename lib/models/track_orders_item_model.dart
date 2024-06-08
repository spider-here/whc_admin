class TrackOrdersItemModel {
  final String id;
  final String orderNumber;
  final String title;
  final String orderType;
  final String subtitle;

  TrackOrdersItemModel({
    required this.id,
    required this.orderNumber,
    required this.title,
    required this.orderType,
    required this.subtitle,
  });

  factory TrackOrdersItemModel.fromMap(String id, Map<String, dynamic> data) {
    return TrackOrdersItemModel(
      id: id,
      orderNumber: data['orderNumber'].toString(),
      title: data['name'] ?? '',
      orderType: data['type'] ?? '',
      subtitle: data['subtitle'] ?? '',
    );
  }
}
