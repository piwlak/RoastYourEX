import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  int? id;
  String? userName;
  String? userImage;
  String? location;
  Timestamp? postTime;
  String? description;
  String? image;
  int? likes;
  int? comments;

  PostModel({
    required this.id,
    required this.userImage,
    required this.userName,
    required this.location,
    required this.postTime,
    required this.description,
    required this.image,
    required this.likes,
    required this.comments,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        id: map['id'],
        userImage: map['userImage'],
        userName: map['userName'],
        location: map['location'],
        postTime: map['postTime'],
        description: map['description'],
        image: map['image'],
        likes: map['likes'],
        comments: map['comments']);
  }

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: data['id'] ?? 0,
      userImage: data['userImage'] ?? '',
      userName: data['userName'] ?? '',
      location: data['location'] ?? '',
      postTime: data['postTime'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      likes: data['likes'] ?? 0,
      comments: data['comments'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userImage'] = this.userImage;
    data['userName'] = this.userName;
    data['location'] = this.location;
    data['postTime'] = this.postTime;
    data['description'] = this.description;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    return data;
  }
}
