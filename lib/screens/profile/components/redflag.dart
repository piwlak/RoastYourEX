import 'package:flutter/material.dart';
import 'package:roastyourex/models/flagmodel.dart';

class RedFlag extends StatelessWidget {
  final FlagModel flag;
  const RedFlag({super.key, required this.flag});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 91, 91),
          borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Center(
          child: Text(
        flag.info!,
        style: TextStyle(color: Colors.black, fontSize: 14),
      )),
    );
  }
}
