import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roastyourex/firebase/firebase_DB.dart';
import 'package:roastyourex/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'components/post_card.dart';
import 'components/profile_card.dart';
import 'post_detail_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  PostFirebase _Post = PostFirebase();
  late PostModel createPost;
  late Timestamp DateStamp;
  late DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Profile",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onBackground)),
          actions: [
            //themeprovider
          ],
        ),
        body: AnimationLimiter(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: MediaQuery.of(context).size.width / 2,
                    child: FadeInAnimation(child: widget),
                  ),
              children: [
                const SizedBox(height: 10),
                const ProfileCard(),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: _Post.getAllPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final posts = snapshot.data!.docs
                          .map((doc) => PostModel.fromFirestore(doc))
                          .toList();
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return PostCard(
                            post: posts[index],
                            onTap: () {
                              Get.to(() => PostDetailPage(
                                    post: post,
                                  ));
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error en la petición, intente de nuevo'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ]),
        )));
  }
}
