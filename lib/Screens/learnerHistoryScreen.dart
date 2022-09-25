import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pointer_v2/Colours.dart';
import 'package:pointer_v2/Screens/homeScreen.dart';
import 'package:pointer_v2/Storage/StorageStructure/History.dart';
import 'package:pointer_v2/Storage/StorageStructure/HistoryList.dart';
import 'package:pointer_v2/Storage/cloudFirestoreControl.dart';
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
  CloudFirestoreControl control = CloudFirestoreControl();

  @override
  String? get restorationId => widget.restorationId;

  Learner get original => widget.clickedLearner;

  @override
  void initState() {}

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${clickedLearner.screenName}'s History"),
        automaticallyImplyLeading: false,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Home(phoneNo: clickedLearner.parentsID);
            }));
          },
        ),
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
                          cancel: () {
                            setState(() {});
                          },
                          selectDate: () {
                            setState(() {});
                            if (startController.text != "" &&
                                endController.text != "" &&
                                dateController.text != "") {
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
                        cancel: () {
                          setState(() {});
                        },
                        selectDate: () {
                          setState(() {});
                          if (startController.text != "" &&
                              endController.text != "" &&
                              dateController.text != "") {
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
                            setState(() {});
                            if (startController.text != "" &&
                                endController.text != "" &&
                                dateController.text != "") {
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
                    Row(
                      children: [
                        Text(
                          "(inclusive) ",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FutureBuilder<HistoryList>(
                builder: (BuildContext context,
                    AsyncSnapshot<HistoryList?> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.connectionState == ConnectionState.done) {
                    HistoryList full = snapshot.data!;
                    full = HistoryList(List.from(full.historyList.reversed));
                    HistoryList list = full;
                    if (dateController.text != "") {
                      DateTime date =
                          DateFormat("dd/MM/yyyy").parse(dateController.text);
                      list.historyList.retainWhere((element) =>
                          date.day ==
                              DateFormat("HH:mm:ss:SSSS dd-MM-yyyy")
                                  .parse(element.timestamp)
                                  .day &&
                          date.month ==
                              DateFormat("HH:mm:ss:SSSS dd-MM-yyyy")
                                  .parse(element.timestamp)
                                  .month &&
                          date.year ==
                              DateFormat("HH:mm:ss:SSSS dd-MM-yyyy")
                                  .parse(element.timestamp)
                                  .year);
                    } else if (startController.text != "" &&
                        endController.text != null) {
                      DateTime startDate =
                          DateFormat("dd/MM/yyyy").parse(startController.text);
                      DateTime endDate =
                          DateFormat("dd/MM/yyyy").parse(endController.text);
                      list.historyList.retainWhere((element) {
                        DateTime timestamp =
                            DateFormat("HH:mm:ss:SSSS dd-MM-yyyy")
                                .parse(element.timestamp);
                        String ts = DateFormat("dd/MM/yyyy").format(timestamp);
                        timestamp = DateFormat("dd/MM/yyyy").parse(ts);
                        return timestamp.millisecondsSinceEpoch >=
                                startDate.millisecondsSinceEpoch &&
                            timestamp.millisecondsSinceEpoch <=
                                endDate.millisecondsSinceEpoch;
                      });
                    } else {
                      list = full;
                    }
                    return Expanded(
                      child: list.historyList.length == 0
                          ? (!(dateController.text != "" ||
                                  (startController.text != "" &&
                                      endController.text != null))
                              ? Center(
                                  child: Text("You dont have any history"),
                                )
                              : Center(
                                  child: Text("Change your filters"),
                                ))
                          : ListView.builder(
                              itemBuilder: (context, i) {
                                DateTime timestamp =
                                    DateFormat("HH:mm:ss:SSSS dd-MM-yyyy")
                                        .parse(list.historyList[i].timestamp);
                                return InkWell(
                                  onTap: () {
                                    History tapped = list.historyList[i];
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("History"),
                                            content: Container(
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Timestamp:",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                        "E d 'of'")
                                                                    .format(
                                                                        timestamp) +
                                                                "\n" +
                                                                DateFormat(
                                                                        "MMMM yyyy")
                                                                    .format(
                                                                        timestamp) +
                                                                "\n" +
                                                                DateFormat(
                                                                        "HH:mm:ss")
                                                                    .format(
                                                                        timestamp),
                                                            style: TextStyle(),
                                                          ),
                                                        ]),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Reason:      ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 20)),
                                                        SizedBox(
                                                          width: 23,
                                                        ),
                                                        Text(list.historyList[i]
                                                            .reason)
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Points:        ",
                                                            style: TextStyle(
                                                                fontSize: 20)),
                                                        SizedBox(
                                                          width: 25,
                                                        ),
                                                        Text(list.historyList[i]
                                                            .points
                                                            .toString())
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: Text("Close")),
                                              TextButton(onPressed: (){
                                                tapped.parentID = clickedLearner.parentsID;
                                                tapped.learnerScreenName = clickedLearner.screenName;
                                                control.deleteHistory(tapped);
                                                clickedLearner.homePoints = clickedLearner.homePoints - tapped.points;
                                                control.updateLearner(clickedLearner, original);
                                                Navigator.pop(context);
                                              }, child: Text("Delete"))
                                            ],
                                          );
                                        });
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                        elevation: 2,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.history,
                                                      size: 60,
                                                      color: Colours.accent,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Timestamp:",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        DateFormat("E d 'of' MMMM yyyy")
                                                                .format(
                                                                    timestamp) +
                                                            "\n" +
                                                            DateFormat(
                                                                    "HH:mm:ss")
                                                                .format(
                                                                    timestamp),
                                                        style: TextStyle(),
                                                      ),
                                                    ]),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Reason:      ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    SizedBox(
                                                      width: 23,
                                                    ),
                                                    Text(list
                                                        .historyList[i].reason)
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Points:        ",
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Text(list
                                                        .historyList[i].points
                                                        .toString())
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                              itemCount: list.historyList.length,
                            ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
                future: control.getHistoryList(
                    clickedLearner.parentsID, clickedLearner.screenName),
              )
            ],
          ),
        ),
      ),
    );
  }
}
