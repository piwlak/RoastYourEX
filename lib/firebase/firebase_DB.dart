import 'package:cloud_firestore/cloud_firestore.dart';

class PostFirebase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? Post;

  PostFirebase() {
    Post = _firestore.collection('Post');
  }

  Future<void> insFavorite(Map<String, dynamic> map) async {
    return Post!.doc().set(map);
  }

  Future<void> updFavorite(Map<String, dynamic> map, String id) async {
    return Post!.doc(id).update(map);
  }

  Future<void> delFavorite(Map<String, dynamic> map, String id) async {
    return Post!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllPost() {
    return Post!.snapshots();
  }
}
