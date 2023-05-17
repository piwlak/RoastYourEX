import 'package:cloud_firestore/cloud_firestore.dart';

class FlagModel {
  String? UID;
  String? info;
  String? id_ex;

  FlagModel({required this.UID, required this.info, required this.id_ex});

  factory FlagModel.fromMap(Map<String, dynamic> map) {
    return FlagModel(
      UID: map['UID'],
      info: map['info'],
      id_ex: map['id_ex'],
    );
  }

  factory FlagModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return FlagModel(
      UID: data['UID'] ?? '',
      info: data['info'] ?? '',
      id_ex: data['id_ex'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UID': UID,
      'info': info,
      'id_ex': id_ex,
    };
  }
}
