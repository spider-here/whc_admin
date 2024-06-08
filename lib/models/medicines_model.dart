class MedicinesModel {
  final String id;
  final String name;
  final String type;
  final String strength;
  final String description;
  final int price;
  final String imageUrl;
  final bool inStock;

  MedicinesModel({required this.id,
    required this.name,
    required this.type,
    required this.strength,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.inStock});

  factory MedicinesModel.fromMap(String id, Map<String, dynamic> data){
    return MedicinesModel(id: data['mId'],
        name: data['name'],
        type: data['type'],
        strength: data['strength'],
        description: data['description'],
        price: data['pricePerPack'],
        imageUrl: data['image'],
        inStock: !data['soldOut']);
  }

}