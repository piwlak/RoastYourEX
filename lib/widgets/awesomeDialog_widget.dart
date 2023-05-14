import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Awesome {
  AwesomeDialog buildDialog(BuildContext context, DialogType type, String title,
      String desc, String route, AnimType atype, bool cancel) {
    return cancel != true
        ? AwesomeDialog(
            context: context,
            dialogType: type,
            animType: atype,
            title: title,
            desc: desc,
            btnOkOnPress: () {
              Navigator.popAndPushNamed(context, route);
            },
          )
        : AwesomeDialog(
            context: context,
            dialogType: type,
            animType: atype,
            title: title,
            desc: desc,
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
            },
          );
  }
}
