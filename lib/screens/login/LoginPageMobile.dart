import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roastyourex/components/theme_helper.dart';
import 'package:roastyourex/firebase/github_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../firebase/email_auth.dart';
import '../../firebase/google_auth.dart';
import '../../widgets/header_widget.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  double _headerHeight = 200;
  final _formKey = GlobalKey<FormState>();
  EmailAuth? auth = EmailAuth();
  GoogleAuth googleAuth = GoogleAuth();
  GitAuth githubAuth = GitAuth();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight,
                  true,
                  Icons
                      .heart_broken_outlined), //let's create a common header widget
            ),
            SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      children: [
                        Text(
                          'Roast Your EX',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 45,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sign in into your account',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  child: TextFormField(
                                      controller: mail,
                                      style: TextStyle(color: Colors.black),
                                      decoration: ThemeHelper()
                                          .textInputDecoration('Email',
                                              'Enter your Email', context),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please enter your User Name";
                                        }
                                        return null;
                                      }),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: TextFormField(
                                      controller: password,
                                      style: TextStyle(color: Colors.black),
                                      obscureText: true,
                                      decoration: ThemeHelper()
                                          .textInputDecoration('Password',
                                              'Enter your password', context),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please enter your Password";
                                        }
                                        return null;
                                      }),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage()),
                                      );
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Sign In'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        auth!
                                            .signInWithEmailAndPassword(
                                                email: mail.text,
                                                password: password.text)
                                            .then((value) {
                                          if (value) {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              'Home',
                                              (route) => false,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                      'Correcto, Bienvenido.')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Correo o Contraseña erroneo.')),
                                            );
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "Don\'t have an account? ",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground)),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationPage()));
                                        },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ])),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  child: SocialLoginButton(
                                    borderRadius: 40,
                                    buttonType: SocialLoginButtonType.google,
                                    onPressed: () async {
                                      isLoading = true;
                                      setState(() {});
                                      await googleAuth
                                          .signInWithGoogle()
                                          .then((value) {
                                        if (value.name != null) {
                                          isLoading = false;
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            'Home',
                                            (route) => false,
                                          );
                                        } else {
                                          isLoading = false;
                                          setState(() {});
                                          SnackBar(
                                            content: Text(
                                                'Verifica tus credenciales'),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  child: SocialLoginButton(
                                    borderRadius: 40,
                                    buttonType: SocialLoginButtonType.github,
                                    onPressed: () async {
                                      isLoading = true;
                                      githubAuth
                                          .signInWithGitHub(context)
                                          .then((value) {
                                        if (value) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            'Home',
                                            (route) => false,
                                          );
                                          isLoading = false;
                                        } else {
                                          isLoading = false;
                                          SnackBar(
                                            content: Text(
                                                'Verifica tus credenciales'),
                                          );
                                        }
                                        setState(() {});
                                      });
                                    },
                                  ),
                                )
                              ],
                            )),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
