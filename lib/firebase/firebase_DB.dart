import 'package:cloud_firestore/cloud_firestore.dart';

class PostFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? Post;

  PostFirebase() {
    Post = _firestore.collection('Post');
  }

  Future<void> insertPost(Map<String, dynamic> map) async {
    return Post!.doc().set(map);
  }

  Future<void> updatePost(Map<String, dynamic> map, String id) async {
    return Post!.doc(id).update(map);
  }

  Future<void> deletePost(Map<String, dynamic> map, String id) async {
    return Post!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllPost(
      {String field = 'postTime', bool descending = true}) {
    return Post!.orderBy(field, descending: descending).snapshots();
  }
}
