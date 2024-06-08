import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsModel {
  final String id;
  final String name;
  final String qualification;
  final String speciality;
  final String email;
  final int phoneNumber;
  final bool isMale;
  final String image;
  final String description;
  final int fee;
  final int rating;
  final bool isApproved;
  final bool isPopular;
  final Timestamp timestamp;

  DoctorsModel(
      {required this.id,
      required this.name,
      required this.qualification,
      required this.speciality,
      required this.email,
      required this.phoneNumber,
      required this.isMale,
      required this.image,
      required this.description,
      required this.fee,
      required this.rating,
      required this.isApproved,
      required this.isPopular,
      required this.timestamp});

  factory DoctorsModel.fromMap(String id, Map<String, dynamic> data) {
    return DoctorsModel(
      id: id,
      name: data['name'] ?? 'Unknown',
      qualification: data['qualification'] ?? 'Unknown',
      speciality: data['speciality'] ?? 'Unknown',
      email: data['email'] ?? 'Unknown',
      phoneNumber: data['phone'] ?? 0,
      isMale: data['isMale'] ?? true,
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      fee: data['fee'] ?? 0,
      rating: data['rating'] ?? 0,
      isApproved: data['isApproved'] ?? false,
      isPopular: data['isPopular'] ?? false,
      timestamp: data['timestamp']
    );
  }
}
