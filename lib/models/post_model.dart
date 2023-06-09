import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  int? id;
  String? userName;
  String? userImage;
  String? location;
  String? userId;
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
    required this.userId,
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
        userId: map['userId'],
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
      userId: data['userId'] ?? '',
      postTime: data['postTime'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      likes: data['likes'] ?? 0,
      comments: data['comments'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'userImage': userImage,
      'location': location,
      'userId': userId,
      'postTime': postTime,
      'description': description,
      'image': image,
      'likes': likes,
      'comments': comments,
    };
  }
}
