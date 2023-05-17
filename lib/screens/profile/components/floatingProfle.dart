import 'package:flutter/material.dart';
import 'package:roastyourex/firebase/flags_DB.dart';
import 'package:roastyourex/models/flagmodel.dart';

import 'addchip.dart';
import 'greenchip.dart';
import 'redchip.dart';

class MyAlertDialog extends StatefulWidget {
  final String userId;
  final String userName;
  final String userPhoto;

  const MyAlertDialog(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userPhoto});

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  FlagFirebase _Flag = FlagFirebase();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 450,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, top: 60, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              widget.userName,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              child: FollowChip(),
                              onTap: () {},
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: StreamBuilder(
                                            stream: _Flag.getSpecificGreenFlags(
                                                widget.userId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final greenflags = snapshot
                                                    .data!.docs
                                                    .map((doc) =>
                                                        FlagModel.fromFirestore(
                                                            doc))
                                                    .toList();
                                                return Column(
                                                  children: greenflags
                                                      .map((greenflag) {
                                                    return GreenFlag(
                                                        flag: greenflag);
                                                  }).toList(),
                                                );
                                              } else if (snapshot.hasError) {
                                                return const Center(
                                                  child: Text(
                                                      'Error en la petición, inténtelo de nuevo'),
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                                        width: 100,
                                        child: StreamBuilder(
                                            stream: _Flag.getSpecificRedFlags(
                                                widget.userId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final redflags = snapshot
                                                    .data!.docs
                                                    .map((doc) =>
                                                        FlagModel.fromFirestore(
                                                            doc))
                                                    .toList();
                                                return Column(
                                                  children:
                                                      redflags.map((redflag) {
                                                    return RedFlag(
                                                        flag: redflag);
                                                  }).toList(),
                                                );
                                              } else if (snapshot.hasError) {
                                                return const Center(
                                                  child: Text(
                                                      'Error en la petición, inténtelo de nuevo'),
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.userPhoto),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
    );
  }
}
