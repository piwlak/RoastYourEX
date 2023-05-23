import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? Usuario;

  UserFirebase() {
    Usuario = _firestore.collection('users');
  }

  Future<void> insertUser(Map<String, dynamic> map) async {
    return Usuario!.doc().set(map);
  }

  Future<void> updateUser(Map<String, dynamic> map, String id) async {
    return Usuario!.doc(id).update(map);
  }

  Future<void> deleteUser(Map<String, dynamic> map, String id) async {
    return Usuario!.doc(id).delete();
  }

  Stream<QuerySnapshot> getSpecificUser(String email) {
    return Usuario!.where('email', isEqualTo: email).snapshots();
  }
}
