import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/track_orders_item_model.dart';

class TrackOrdersController extends GetxController {
  RxInt dropdownStatusValue = 0.obs;

  final filterText = [
    'All',
    'Pending',
    'Accepted',
    'On the Way',
    'Completed',
  ];

  dropdownStatusOnChanged(int value) {
    dropdownStatusValue.value = value;
  }

  String getDateTime(Timestamp timestamp) {
    final Timestamp ts = timestamp;
    final DateTime dateTime = ts.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    final dateString = dateTime.toString();
    return dateString;
  }

  Stream<List<TrackOrdersItemModel>> getOrdersByStatus() {
    int statusValue = dropdownStatusValue.value;

    Query<Map<String, dynamic>> query;
    switch (statusValue) {
      case 1:
        query = FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "pending");
        break;
      case 2:
        query = FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "accepted");
        break;
      case 3:
        query = FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "onTheWay");
        break;
      case 4:
        query = FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: "completed");
        break;
      default:
        query = FirebaseFirestore.instance
            .collection('orders')
            .orderBy('orderNumber', descending: true);
        break;
    }

    return query.snapshots().asyncMap((snapshot) async {
      return Future.wait(snapshot.docs.map((doc) async {
        var data = doc.data();
        if (statusValue != 0 && data['type'] == 'labTest') {
          String labTestId = data['ltId'];
          DocumentSnapshot<Map<String, dynamic>> labTestSnapshot =
          await FirebaseFirestore.instance
              .collection('labTests')
              .doc(labTestId)
              .get();
          data['subtitle'] = labTestSnapshot.data()?['fee']?.toString() ?? '';
        } else {
          if (statusValue == 0) {
            data['subtitle'] = data['status'];
          } else {
            data['subtitle'] = data['totalAmount']?.toString();
          }
        }
        return TrackOrdersItemModel.fromMap(doc.id, data);
      }).toList());
    });

  }



}
