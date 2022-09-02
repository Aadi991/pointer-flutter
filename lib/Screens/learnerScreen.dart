// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Action;

import '../Colours.dart';
import '../Storage/StorageStructure/Action.dart';
import '../Storage/StorageStructure/ActionList.dart';
import '../Storage/StorageStructure/Learner.dart';
import '../Storage/cloudFirestoreControl.dart';

class LearnerScreen extends StatefulWidget {
  Learner clickedLearner;

  LearnerScreen({Key? key, required this.clickedLearner}) : super(key: key);

  @override
  State<LearnerScreen> createState() => _LearnerScreenState();
}

class _LearnerScreenState extends State<LearnerScreen> {
  Learner clickedLearner = Learner.empty();
  Learner original = Learner.empty();
  int imageSize = 125;
  int rewardsLength = 4;
  int penaltiesLength = 3;
  CloudFirestoreControl control = CloudFirestoreControl();

  TextEditingController reasonController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    original = widget.clickedLearner;
    clickedLearner = widget.clickedLearner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Do you want to save your changes?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              control.updateLearner(clickedLearner, original);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(onPressed: (){
                            Navigator.pop(context);

                          }, child: Text("Take me back"))
                        ],
                      ));
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(clickedLearner.fullName!),
          centerTitle: true,
          elevation: 10,
          actions: [
            PopupMenuButton<String>(onSelected: (String result) async {
              if (result == Options.delete) {
                await FirebaseFirestore.instance
                    .collection("Schools")
                    .doc(clickedLearner.schoolID)
                    .collection("Learners")
                    .doc(clickedLearner.fullName)
                    .delete();
                Navigator.pop(context);
              } else if (result == Options.edit) {
                if (kDebugMode) {
                  print("editing");
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditLearnerScreen(
                              currentLearner: clickedLearner,schoolID: clickedLearner.schoolID!,
                            )));
              }
            }, itemBuilder: (BuildContext context) {
              return Options.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            })
          ],
        ),
        body: GestureDetector(
          onVerticalDragUpdate: (details) async {
            if (details.delta.dy > 0) {
              clickedLearner = (await control.getLearner(
                  clickedLearner.schoolID!, clickedLearner.fullName!))!;
              setState(() {});
            }
          },
          child: FutureBuilder<ActionList>(
            builder:
                (BuildContext context, AsyncSnapshot<ActionList> snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.connectionState == ConnectionState.done) {
                ActionList actions = snapshot.data!;
                List<Action> rewards = List<Action>.empty(growable: true);
                List<Action> penalties = List<Action>.empty(growable: true);
                for (var element in actions.actionList!) {
                  if (element.points > 0) {
                    rewards.add(element);
                  } else {
                    penalties.add(element);
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset("images/Learner.png",
                                          height: imageSize.toDouble(),
                                          width: imageSize.toDouble()),
                                      SizedBox(
                                        width: ((MediaQuery.of(context)
                                                .size
                                                .width) /
                                            16),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Points:",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colours.accent),
                                          ),
                                          Text(
                                            clickedLearner.schoolPoints
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      'images/ranks/Beginner.png',
                                      height: 120,
                                      width: 120,
                                    ),
                                    SizedBox(
                                      width:
                                          ((MediaQuery.of(context).size.width) /
                                              16),
                                    ),
                                    InkWell(
                                      child: Icon(Icons.history,
                                          color: Colours.accent, size: 100),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HistoryScreen(
                                                        clickedLearner:
                                                            clickedLearner)));
                                      },
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rewards",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colours.accent),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return ((index == rewards.length)
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Add Reward"),
                                                      content: SizedBox(
                                                        height: 200,
                                                        child: Column(
                                                          children: [
                                                            TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          "Reason"),
                                                              controller:
                                                                  reasonController,
                                                            ),
                                                            TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          "Points"),
                                                              controller:
                                                                  pointsController,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: Text("Cancel"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text("Add"),
                                                          onPressed: () {
                                                            if (reasonController
                                                                        .text ==
                                                                    null ||
                                                                pointsController
                                                                        .text ==
                                                                    null) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          "Error"),
                                                                      content: Text(
                                                                          "Please fill in all fields"),
                                                                      actions: [
                                                                        TextButton(
                                                                          child:
                                                                              Text("OK"),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            } else {
                                                              control.setAction(
                                                                  Action(
                                                                      reasonController
                                                                          .text,
                                                                      int.parse(
                                                                          pointsController
                                                                              .text)),
                                                                  widget
                                                                      .clickedLearner
                                                                      .schoolID!,
                                                                  widget
                                                                      .clickedLearner
                                                                      .fullName!);
                                                              setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                                rewards.add(Action(
                                                                    reasonController
                                                                        .text,
                                                                    int.parse(
                                                                        pointsController
                                                                            .text)));
                                                                reasonController
                                                                    .clear();
                                                                pointsController
                                                                    .clear();
                                                              });
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  });
                                            });
                                          },
                                          child: Icon(Icons.add_circle,
                                              color: Colours.accent, size: 100),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              clickedLearner.schoolPoints =
                                                  clickedLearner.schoolPoints! +
                                                      rewards[index].points;
                                            });
                                          },
                                          onLongPress: () {
                                            setState(() {
                                              rewards.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Color.fromARGB(
                                                        166, 255, 215, 0),
                                                    size: 50,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ((MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                          16),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      rewards[index]
                                                          .points
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colours.accent),
                                                    ),
                                                    Text(
                                                      rewards[index].reason,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                },
                                itemCount: rewards.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 10,
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Penalties",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colours.accent),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == penalties.length) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Add Penalty"),
                                                  content: SizedBox(
                                                    height: 200,
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "Reason"),
                                                          controller:
                                                              reasonController,
                                                        ),
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "Points"),
                                                          controller:
                                                              pointsController,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Add"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        penalties.add(Action(
                                                            reasonController
                                                                .text,
                                                            int.parse(
                                                                pointsController
                                                                    .text)));
                                                        control.setAction(
                                                            Action(
                                                                reasonController
                                                                    .text,
                                                                int.parse(
                                                                    pointsController
                                                                        .text)),
                                                            widget
                                                                .clickedLearner
                                                                .schoolID!,
                                                            widget
                                                                .clickedLearner
                                                                .fullName!);
                                                        reasonController
                                                            .clear();
                                                        pointsController
                                                            .clear();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        });
                                      },
                                      child: Icon(Icons.add_circle,
                                          color: Colours.accent, size: 100),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          clickedLearner.schoolPoints =
                                              clickedLearner.schoolPoints! +
                                                  penalties[index].points;
                                        });
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          penalties.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                            SizedBox(
                                              width: ((MediaQuery.of(context)
                                                      .size
                                                      .width) /
                                                  16),
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  penalties[index]
                                                      .points
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colours.accent),
                                                ),
                                                Text(
                                                  penalties[index].reason,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                itemCount: penalties.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    width: 10,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
            future: control.getActionList(widget.clickedLearner.schoolID!,
                widget.clickedLearner.fullName!),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    reasonController.dispose();
    pointsController.dispose();
  }
}

class Options {
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const List<String> choices = [delete, edit];
}
