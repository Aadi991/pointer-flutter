import 'package:flutter/material.dart';
import 'package:pointer_v2/Screens/learnerScreen.dart';
import 'package:pointer_v2/Screens/profileScreen.dart';
import 'package:pointer_v2/Storage/StorageStructure/LearnerList.dart';
import 'package:pointer_v2/Storage/cloudFirestoreControl.dart';
import 'package:pointer_v2/Widgets/learnerListWidget.dart';

class Home extends StatefulWidget {
  String phoneNo;

  Home({Key? key, required this.phoneNo}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(phoneNo);
}

class _HomeState extends State<Home> {
  String phoneNo;
  CloudFirestoreControl control = CloudFirestoreControl();

  _HomeState(this.phoneNo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Home"),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: Icon(
                Icons.account_circle,
                size: 50,
              ),
            ),
          ],
        ),
        body: GestureDetector(onVerticalDragUpdate: (details) async {
          if (details.delta.dy > 0) {
            setState(() {});
          }
        }, child: FutureBuilder(builder:
            (BuildContext context, AsyncSnapshot<LearnerList?> snapshot) {
          LearnerList learnerList = snapshot.data!;
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: 650,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: learnerList.learnerList.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Row(key: UniqueKey(), children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.symmetric(
                            vertical: 2.5, horizontal: 5),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.5, horizontal: 5),
                        child: LearnerListWidget(
                            onPressed: () {
                              print("pressed");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LearnerScreen(
                                            clickedLearner:
                                            learnerList.learnerList[index],
                                          )));
                            },
                            onLongPress: () {
                              print("long pressed");
                            },
                            clickedStudent:
                            learnerList.learnerList[index]),
                      ),
                    ),
                  ]);
                },
              ),
            );
          }else{
            return CircularProgressIndicator();
          }
        },
          future: control.getLearnerList(phoneNo),
        )));
  }
}
