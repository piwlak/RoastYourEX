import 'package:cloud_firestore/cloud_firestore.dart';

class FlagFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? GreenFlag;
  CollectionReference? RedFlag;

  FlagFirebase() {
    GreenFlag = _firestore.collection('greenflag');
    RedFlag = _firestore.collection('redflag');
  }

  Future<void> insertGreenFlag(Map<String, dynamic> map) async {
    return GreenFlag!.doc().set(map);
  }

  Future<void> updateGreenFlag(Map<String, dynamic> map, String id) async {
    return GreenFlag!.doc(id).update(map);
  }

  Future<void> deleteGreenFlag(Map<String, dynamic> map, String id) async {
    return GreenFlag!.doc(id).delete();
  }

  Stream<QuerySnapshot> getSpecificGreenFlags(String id) {
    return GreenFlag!.where('id_ex', isEqualTo: id).snapshots();
  }

  //redflag

  Future<void> insertRedFlag(Map<String, dynamic> map) async {
    return RedFlag!.doc().set(map);
  }

  Future<void> updateRedFlag(Map<String, dynamic> map, String id) async {
    return RedFlag!.doc(id).update(map);
  }

  Future<void> deleteRedFlag(Map<String, dynamic> map, String id) async {
    return RedFlag!.doc(id).delete();
  }

  Stream<QuerySnapshot> getSpecificRedFlags(String id) {
    return RedFlag!.where('id_ex', isEqualTo: id).snapshots();
  }
}
