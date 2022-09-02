// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointer_v2/Screens/phoneAuthScreen.dart';
import 'package:pointer_v2/Storage/StorageStructure/Parent.dart';
import 'package:pointer_v2/Widgets/getParentDataWidget.dart';
import 'package:pointer_v2/Widgets/viewParentDataWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colours.dart';
import '../Storage/cloudFirestoreControl.dart';
import '../Utils.dart';
import '../main.dart';
import '../toast.dart';
import 'homeScreen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _editing = true;
  bool progress = false;
  bool _seeData = true;
  String prefKey = SharedPrefsKeys.phoneNoKey;
  int userDataStackIndex = 0;
  int collapseStackIndex = 0;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController screenNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController parentPinController = TextEditingController();
  CloudFirestoreControl control = CloudFirestoreControl();
  bool _progress = false;
  bool editing = false;
  late Parent currentParent;
  String phoneNo = "";

  @override
  void initState() {
    super.initState();
    userDataStackIndex = _editing ? 1 : 0;
    collapseStackIndex = _seeData ? 0 : 1;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (FirebaseAuth.instance.currentUser == null)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      User current = FirebaseAuth.instance.currentUser!;
      String phoneNo = current.phoneNumber!;
      print(phoneNo);
      phoneNumberController.text = phoneNo;
      if (await control.checkIfDocumentExists("/Parents/$phoneNo")) {
        setState(() {
          editing = true;
        });
        currentParent = await control.getParent(phoneNo);
        fullNameController.text = currentParent.fullName;
        screenNameController.text = currentParent.screenName;
        phoneNumberController.text = currentParent.phoneNumber;
        ageController.text = currentParent.age.toString();
        parentPinController.text = currentParent.pin.toString();
      }
    });
  }

  void setPhoneNo(String phoneNo) async {
    setState(() {
      progress = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(prefKey, phoneNo);
    setState(() {
      progress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(ModalRoute.of(context)?.settings.name);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(phoneNo: phoneNo))),
        ),
      ),
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            progress
                ? Center(child: CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(left: 30, top: 75, right: 30),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Icon(
                              Icons.account_circle,
                              size: 125,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          collapseStackIndex == 0
                              ? Column(
                                  children: [
                                    userDataStackIndex == 0
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Full Name:",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      fullNameController
                                                                  .value ==
                                                              null
                                                          ? "Unknown"
                                                          : fullNameController
                                                              .value.text,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    child: Icon(Icons.edit,
                                                        color: Colours.accent,
                                                        size: 16),
                                                    onTap: () {
                                                      setState(() {
                                                        print(
                                                            userDataStackIndex);
                                                        userDataStackIndex =
                                                            userDataStackIndex ==
                                                                    0
                                                                ? 1
                                                                : 0;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              GetParentData(
                                                  screenNameController:
                                                      screenNameController,
                                                  phoneNumberController:
                                                      phoneNumberController,
                                                  ageController: ageController,
                                                  fullNameController:
                                                      fullNameController,
                                                  parentPinController:
                                                      parentPinController,
                                                  index: userDataStackIndex)
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Full Name:",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          fullNameController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: "Full Name",
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    child: Icon(Icons.edit,
                                                        color: Colours.accent,
                                                        size: 16),
                                                    onTap: () {
                                                      setState(() {
                                                        userDataStackIndex =
                                                            userDataStackIndex ==
                                                                    0
                                                                ? 1
                                                                : 0;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              ViewParentData(
                                                  screenNameController:
                                                      screenNameController,
                                                  phoneNumberController:
                                                      phoneNumberController,
                                                  ageController: ageController,
                                                  parentPinController:
                                                      parentPinController,
                                                  index: userDataStackIndex)
                                            ],
                                          ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("User Data",
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Icon(
                                collapseStackIndex == 0
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.grey,
                                size: 30),
                            onTap: () {
                              setState(() {
                                collapseStackIndex =
                                    collapseStackIndex == 0 ? 1 : 0;
                              });
                            },
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                progress = true;
                              });
                              await FirebaseAuth.instance.signOut();
                              setState(() {
                                progress = false;
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SplashPage();
                              }));
                            },
                            child: Text(
                              "Logout",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colours.accent),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: Colours.accent,
                                                width: 1))),
                                  ),
                                  onPressed: () {
                                    if (fullNameController.text.isEmpty) {
                                      showToast('Please enter your full name');
                                    } else if (screenNameController
                                        .text.isEmpty) {
                                      showToast(
                                          'Please enter your screen name');
                                    } else if (phoneNumberController
                                        .text.isEmpty) {
                                      showToast(
                                          'Please enter your phone number');
                                    } else if (ageController.text.isEmpty) {
                                      showToast('Please enter your age');
                                    } else {
                                      setState(() {
                                        _progress = true;
                                      });
                                      if (editing) {
                                        if (currentParent.phoneNumber !=
                                            phoneNumberController.text) {
                                          showToast(
                                              "If you want to change your phone number please sign in with a different number, you will be redirected to do so");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn()));
                                        } else
                                          control.updateParent(
                                              currentParent,
                                              Parent.withoutLists(
                                                  fullNameController.text,
                                                  screenNameController.text,
                                                  phoneNumberController.text,
                                                  int.parse(ageController.text),
                                                  int.parse(parentPinController
                                                      .text)));
                                      } else {
                                        control.setParent(Parent.withoutLists(
                                            fullNameController.text,
                                            screenNameController.text,
                                            phoneNumberController.text,
                                            int.parse(ageController.text),
                                            int.parse(
                                                parentPinController.text)));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Home(phoneNo: phoneNo)));
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(phoneNo: phoneNo)));
                                      }
                                    }
                                    setState(() {
                                      _progress = false;
                                    });
                                  },
                                  child: Text(
                                    editing ? "Update" : "Sign Up",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _progress
                                  ? CircularProgressIndicator()
                                  : Container(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
