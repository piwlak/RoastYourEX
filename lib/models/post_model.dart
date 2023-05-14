import 'package:roastyourex/utils/assets.dart';

class PostModel {
  int? id;
  String? userName;
  String? userImage;
  String? location;
  String? postTime;
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

  PostModel.fromJson(Map<String, dynamic> json) {}

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

List<PostModel> dummyPosts = [
  PostModel(
      id: 1,
      userName: 'John Milke',
      location: 'Berlin,Germany',
      postTime: '5 min ago',
      userImage: CustomAssets.kUser2,
      description:
          'At vero eos et accusamus et iusto odio dignissimos ducimus qui dolores et quas molestias excepturi sint occaecati cupiditate non provident',
      image: CustomAssets.kPost1,
      likes: 53,
      comments: 103),
  PostModel(
      id: 1,
      userName: 'Steve Douglas',
      location: 'New york,USA',
      postTime: '44m ago',
      userImage: CustomAssets.kUser4,
      description:
          "Blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident",
      image: CustomAssets.kPost2,
      likes: 54,
      comments: 10444),
];
