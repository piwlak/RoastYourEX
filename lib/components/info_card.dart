import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.mail,
  }) : super(key: key);

  final String name, mail;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user!.photoURL!)),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        mail,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
