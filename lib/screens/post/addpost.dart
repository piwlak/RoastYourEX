import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roastyourex/components/theme_helper.dart';
import 'package:roastyourex/models/post_model.dart';
import 'package:roastyourex/screens/login/select_photo_options_screen.dart';
import 'package:roastyourex/widgets/awesomeDialog_widget.dart';
import 'package:geocoding/geocoding.dart';

class addPost extends StatefulWidget {
  const addPost({super.key});

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _image;
  final user = FirebaseAuth.instance.currentUser;
  Awesome awesome = Awesome();

  TextEditingController txtdescription = TextEditingController();
  TextEditingController txtLocation = TextEditingController();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  Future<void> getLocation() async {
    // Comprobar si los permisos de ubicación están habilitados
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Solicitar permisos de ubicación
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Si el usuario niega el permiso de ubicación, mostrar un mensaje de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Los permisos de ubicación están deshabilitados.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }
  }

  Future<String> getCityAndCountry(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String city = placemark.locality ?? "";
        String country = placemark.country ?? "";
        return "$city, $country";
      }
    } catch (e) {
      print("Error getting city and country: $e");
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Upload a Post",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onBackground)),
          actions: [
            //themeprovider
          ],
        ),
        body: AnimationLimiter(
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset:
                              MediaQuery.of(context).size.width / 2,
                          child: FadeInAnimation(child: widget),
                        ),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                _showSelectPhotoOptions(context);
                              },
                              child: Center(
                                child: Container(
                                    height: 200.0,
                                    width: 400.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: _image == null
                                            ? Text(
                                                'Selecciona tu Imagen',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              )
                                            : Column(
                                                children: <Widget>[
                                                  Image.file(
                                                    _image!,
                                                    height: 200,
                                                    width: 400,
                                                  )
                                                ],
                                              ))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: TextFormField(
                                controller: txtdescription,
                                maxLines: 8,
                                style: TextStyle(color: Colors.black),
                                decoration: ThemeHelper()
                                    .textInputDecorationlong('Description', ''),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter the description";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Text(
                                    'Upload Post'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  //Storage
                                  String filename =
                                      ('${user!.uid.toString()}_${DateTime.now().toString()}.jpg');
                                  Reference ref = storage.ref().child(filename);
                                  UploadTask uploadTask = ref.putFile(_image!);
                                  TaskSnapshot snapshot =
                                      await uploadTask.whenComplete(() => null);
                                  String downloadUrl =
                                      await snapshot.ref.getDownloadURL();
                                  //Database
                                  final random = Random();
                                  final now = DateTime.now();
                                  final timestamp = Timestamp.fromDate(now);
                                  //Location
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.high);
                                  String pos =
                                      await getCityAndCountry(position);

                                  PostModel post = PostModel(
                                      id: random.nextInt(999999),
                                      userImage: user!.photoURL,
                                      userName: user!.displayName,
                                      location: pos,
                                      postTime: timestamp,
                                      description: txtdescription.text,
                                      image: downloadUrl,
                                      likes: 0,
                                      comments: 0);
                                  Map<String, dynamic> postMap = post.toMap();
                                  _firestore
                                      .collection('Post')
                                      .add(postMap)
                                      .then((value) {
                                    awesome
                                        .buildDialog(
                                            context,
                                            DialogType.SUCCES,
                                            'Listo',
                                            'El Post se ha subido con exito',
                                            'Home',
                                            AnimType.BOTTOMSLIDE,
                                            true)
                                        .show()
                                        .then((value) {});
                                  }).catchError((error) {
                                    awesome
                                        .buildDialog(
                                            context,
                                            DialogType.ERROR,
                                            'Error',
                                            'Hubo un error al subirlo intentelo de nuevo',
                                            'Home',
                                            AnimType.BOTTOMSLIDE,
                                            true)
                                        .show()
                                        .then((value) {});
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ]))));
  }
}
