import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:roastyourex/models/rive_asset.dart';
import 'package:roastyourex/widgets/awesomeDialog_widget.dart';
import 'package:roastyourex/widgets/rive_utils.dart';

import 'info_card.dart';
import 'side_menu_tile.dart';

// Welcome to the Episode 5
class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Awesome awesome = Awesome();

    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: user!.displayName!,
                mail: user.email!,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    // Let me show you if user click on the menu how to show the animation
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                    // See as we click them it start animate
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              SideMenuTile(
                menu: sidemenu2,
                riveonInit: (artboard) {},
                press: () {
                  try {
                    awesome
                        .buildDialog(
                            context,
                            DialogType.INFO_REVERSED,
                            'Confirmar',
                            '¿Realmente desea cerrar la sesión?',
                            '/login',
                            AnimType.BOTTOMSLIDE,
                            true)
                        .show()
                        .then((value) {});
                  } catch (e) {
                    e;
                  }
                },
                isActive: selectedMenu == sidemenu2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
