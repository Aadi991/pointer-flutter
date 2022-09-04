// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointer_v2/Screens/phoneAuthScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Colours.dart';
import 'Screens/profileScreen.dart';
import 'Storage/cloudFirestoreControl.dart';
import 'Utils.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  /*CloudFirestoreControl control = CloudFirestoreControl();
  runApp(LearnerScreen(clickedLearner: await control.getLearner("+919880721381", "Aadi")));*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      primarySwatch: Colours.accentMat,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Quicksand',
    );

    return MaterialApp(
        theme: themeData, title: 'Flutter Demo', home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  CloudFirestoreControl? control;

  String random10DigitNumber() {
    String ret = " ";
    for (int i = 0; i < 10; i++) {
      ret = ret + Utils.randomRange(1, 9).toString();
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pointer Teachers",
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF9AA33)),
              textAlign: TextAlign.center,
            ),
            Text(
              "Children, are you well behaved?",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    control = CloudFirestoreControl();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseAuth.instance.currentUser != null
          ? {
              GlobalVariables.profileFrom = ProfileFrom.SplashPage,
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              )
            }
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
    });
  }
}
