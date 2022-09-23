import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pointer_v2/Widgets/dateRangeTextField.dart';
import 'package:pointer_v2/Widgets/dateTextField.dart';

import '../Storage/StorageStructure/Learner.dart';

class LearnerHistory extends StatefulWidget {
  Learner clickedLearner;

  String restorationId;

  LearnerHistory(
      {Key? key, required this.clickedLearner, required this.restorationId})
      : super(key: key);

  @override
  State<LearnerHistory> createState() => _LearnerHistoryState(clickedLearner);
}

class _LearnerHistoryState extends State<LearnerHistory> {
  Learner clickedLearner;

  _LearnerHistoryState(this.clickedLearner);

  TextEditingController dateController = TextEditingController(text: "");
  TextEditingController startController = TextEditingController(text: "");
  TextEditingController endController = TextEditingController(text: "");

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${clickedLearner.screenName}'s History"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) async {
          if (details.delta.dy > 0) {
            setState(() {});
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Filters",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Date:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: DateTextField(
                          restorationId: widget.restorationId,
                          selectedDate: _selectedDate,
                          dateController: dateController,
                          selectDate: () {
                            if(startController.text != "" && endController.text != "" && dateController.text != ""){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "You cannot have more than one filter, which one do you want to keep?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              startController.text = "";
                                              endController.text = "";
                                              Navigator.pop(context);
                                            },
                                            child: Text("Single Date")),
                                        TextButton(
                                            onPressed: () {
                                              dateController.text = "";
                                              Navigator.pop(context);
                                            },
                                            child: Text("Range of Dates"))
                                      ],
                                    );
                                  });
                            }
                          },
                        ))
                      ],
                    ),
                    Row(children: [
                      Text(
                        "Between ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: DateRangeTextField(
                        restorationId: widget.restorationId,
                        selectedDate: RestorableDateTime(DateTime.now()),
                        startDateController: startController,
                        endDateController: endController,
                        isStartDate: true,
                        selectDate: () {
                          if(startController.text != "" && endController.text != "" && dateController.text != ""){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "You cannot have more than one filter, which one do you want to keep?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            startController.text = "";
                                            endController.text = "";
                                            Navigator.pop(context);
                                          },
                                          child: Text("Single Date")),
                                      TextButton(
                                          onPressed: () {
                                            dateController.text = "";
                                            Navigator.pop(context);
                                          },
                                          child: Text("Range of Dates"))
                                    ],
                                  );
                                });
                          }
                        },
                      )),
                      SizedBox(
                        width: 20,
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          "and ",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: DateRangeTextField(
                          restorationId: widget.restorationId,
                          selectedDate: RestorableDateTime(DateTime.now()),
                          startDateController: startController,
                          endDateController: endController,
                          isStartDate: false,
                          selectDate: () {
                            if(startController.text != "" && endController.text != "" && dateController.text != ""){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "You cannot have more than one filter, which one do you want to keep?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              startController.text = "";
                                              endController.text = "";
                                              Navigator.pop(context);
                                            },
                                            child: Text("Single Date")),
                                        TextButton(
                                            onPressed: () {
                                              dateController.text = "";
                                              Navigator.pop(context);
                                            },
                                            child: Text("Range of Dates"))
                                      ],
                                    );
                                  });
                            }
                          },
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
