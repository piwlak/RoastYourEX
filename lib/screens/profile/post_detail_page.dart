import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roastyourex/models/post_model.dart';
import 'package:roastyourex/utils/assets.dart';

import 'components/floatingProfle.dart';

// ignore: must_be_immutable
class PostDetailPage extends StatelessWidget {
  PostModel post;
  PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp? timestamp = post.postTime;
    DateTime dateTime = timestamp!.toDate();
    Duration difference = DateTime.now().difference(dateTime);
    String time;

    if ((difference.inMinutes) < 60) {
      time = '${difference.inMinutes} minutos';
    } else if ((difference.inHours) < 24) {
      time = '${difference.inHours} horas';
    } else {
      time = '${difference.inDays} días';
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onBackground,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: [
          Hero(
            tag: post.id!,
            child: Container(
              height: 400,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(post.image!), fit: BoxFit.cover)),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(post.userImage!),
                          fit: BoxFit.cover)),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      print(post.userId);
                      return MyAlertDialog(
                        userId: post.userId!,
                        userName: post.userName!,
                        userPhoto: post.userImage!,
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${post.location} • hace ${time}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              const Spacer(),
              const SizedBox(width: 5),
              const Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.description!,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(
                CustomAssets.kHeart,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 2),
              Text(
                '${post.likes.toString()}k',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                CustomAssets.kChat,
                height: 25,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 2),
              Text(
                '${post.comments.toString()}k',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const Spacer(),
              SvgPicture.asset(
                CustomAssets.kShare,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
