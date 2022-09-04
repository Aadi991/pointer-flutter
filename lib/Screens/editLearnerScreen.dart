// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:pointer_v2/Storage/StorageStructure/ChildRank.dart';
import 'package:pointer_v2/Storage/StorageStructure/Learner.dart';
import '../Storage/cloudFirestoreControl.dart';
import '../Utils.dart';

class EditLearnerScreen extends StatefulWidget {
  Learner currentLearner;

  EditLearnerScreen({Key? key, required this.currentLearner}) : super(key: key);

  @override
  State<EditLearnerScreen> createState() => _EditLearnerScreenState(currentLearner);
}

class _EditLearnerScreenState extends State<EditLearnerScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _screenNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _teachersIDController = TextEditingController();
  TextEditingController _parentsIDController = TextEditingController();
  CloudFirestoreControl control = CloudFirestoreControl();
  bool loading = false;
  Learner currentLearner;
  String gender = "";

  _EditLearnerScreenState(this.currentLearner);


  @override
  void initState() {
    _fullNameController.text = currentLearner.fullName;
    _screenNameController.text = currentLearner.screenName;
    _phoneNoController.text = currentLearner.phoneNumber;
    _ageController.text = currentLearner.age.toString();
    _teachersIDController.text = currentLearner.teachersID;
    _parentsIDController.text = currentLearner.parentsID;
    gender = currentLearner.isBoy ? "Boy":"Girl";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Edit Student'),
        ),
        body: SingleChildScrollView(
          child: loading
              ? Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text('Cancel')),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      TextField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _screenNameController,
                        decoration: InputDecoration(
                          labelText: 'Screen Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _phoneNoController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          labelText: 'Age',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _teachersIDController,
                        decoration: InputDecoration(
                          labelText: 'Teachers ID',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _parentsIDController,
                        decoration: InputDecoration(
                          labelText: 'Parents ID',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Boy'),
                              leading: Radio<String>(
                                value: "Boy",
                                groupValue: gender,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Girl'),
                              leading: Radio<String>(
                                value: "Girl",
                                groupValue: gender,
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_fullNameController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else if (_screenNameController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else if (_phoneNoController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else if (_ageController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else if (_teachersIDController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else if (_parentsIDController == null) {
                              Utils.showSnackBar(
                                  context, "Fill all the fields");
                              return;
                            } else {
                              control.updateLearner(Learner.withOutLists(
                                  _fullNameController.text,
                                  _screenNameController.text,
                                  _phoneNoController.text,
                                  int.parse(_ageController.text),
                                  _teachersIDController.text,
                                  _parentsIDController.text,
                                  "",
                                  ChildRank.None,
                                  0,
                                  gender == "Boy" ? true : false), currentLearner);
                            }
                            Navigator.pop(context);
                          },
                          child: Text("Submit"))
                    ],
                  ),
                ),
        ));
  }
}
