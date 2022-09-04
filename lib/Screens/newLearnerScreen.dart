// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:pointer_v2/Storage/StorageStructure/ChildRank.dart';
import 'package:pointer_v2/Storage/StorageStructure/Learner.dart';
import '../Storage/cloudFirestoreControl.dart';
import '../Utils.dart';

class NewLearnerScreen extends StatefulWidget {
  String phoneNo;

  NewLearnerScreen({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<NewLearnerScreen> createState() => _NewLearnerScreenState(phoneNo);
}

class _NewLearnerScreenState extends State<NewLearnerScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _screenNameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _teachersIDController = TextEditingController();
  TextEditingController _parentsIDController = TextEditingController();
  CloudFirestoreControl control = CloudFirestoreControl();
  bool loading = false;
  String phoneNo;
  String gender = "";

  _NewLearnerScreenState(this.phoneNo);


  @override
  void initState() {
    _parentsIDController.text = phoneNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('New Learner'),
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
                              control.setLearner(Learner.withOutLists(
                                  _fullNameController.text,
                                  _screenNameController.text,
                                  _phoneNoController.text,
                                  int.parse(_ageController.text),
                                  _teachersIDController.text,
                                  _parentsIDController.text,
                                  "",
                                  ChildRank.None,
                                  0,
                                  gender == "Boy" ? true : false));
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
