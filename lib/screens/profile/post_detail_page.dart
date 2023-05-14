import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roastyourex/models/post_model.dart';
import 'package:roastyourex/utils/assets.dart';

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

    if ((difference.inMinutes % 60) < 60) {
      time = '${difference.inMinutes % 60} minutos';
    } else if ((difference.inHours % 24) < 24) {
      time = '${difference.inHours % 24} horas';
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25)),
                child: const Text('Schedule a meeting',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Send a message',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 14)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25)),
                child: Text('Details',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 14)),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(post.userImage!),
                        fit: BoxFit.cover)),
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
          Text(
            "All Comments",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 10),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(CustomAssets.kUser4),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Steve John • ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          Text(
                            "5m ago",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        post.description!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
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
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 2)
        ],
      ),
    );
  }
}
