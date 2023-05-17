import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roastyourex/firebase/flags_DB.dart';
import 'package:roastyourex/models/flagmodel.dart';
import 'addchip.dart';
import 'redchip.dart';
import 'greenchip.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  FlagFirebase _Flag = FlagFirebase();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 60, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(
                user!.displayName!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                child: FollowChip(),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150, // Define el ancho del contenedor
                        child: StreamBuilder(
                            stream: _Flag.getSpecificGreenFlags(user.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final greenflags = snapshot.data!.docs
                                    .map((doc) => FlagModel.fromFirestore(doc))
                                    .toList();
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final greenflag = greenflags;
                                    return GreenFlag(flag: greenflag[index]);
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text(
                                      'Error en la peticion, intente de nuevo'),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150, // Define el ancho del contenedor
                        child: StreamBuilder(
                            stream: _Flag.getSpecificRedFlags(user.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final redflags = snapshot.data!.docs
                                    .map((doc) => FlagModel.fromFirestore(doc))
                                    .toList();
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final redflag = redflags;
                                    return RedFlag(flag: redflag[index]);
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text(
                                      'Error en la peticion, intente de nuevo'),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
      ],
    );
  }
}
