import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (user!.photoURL != null) {
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
    } else {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final name = userData['name'];
            final mail = userData['email'];
            final photoURL = userData['photoURL'];

            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(photoURL)),
              title: Text(
                name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                mail,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error al cargar los datos del usuario');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }
  }
}
