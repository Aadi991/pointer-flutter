import 'package:flutter/material.dart';
import 'package:pointer_v2/Storage/StorageStructure/Learner.dart';

import '../Colours.dart';

class LearnerListWidget extends StatefulWidget {
  Function onPressed;
  Function onLongPress;
  Learner clickedStudent;

  LearnerListWidget(
      {Key? key,
      required this.onPressed,
      required this.onLongPress,
      required this.clickedStudent})
      : super(key: key);

  @override
  State<LearnerListWidget> createState() => _LearnerListWidgetState();
}

class _LearnerListWidgetState extends State<LearnerListWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      onLongPress: () {
        widget.onLongPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/student.png',
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.clickedStudent.fullName??'',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.clickedStudent.age.toString(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Points:",
                    style: TextStyle(fontSize: 20, color: Colours.accent)),
                SizedBox(
                  width:10
                ),
                Text(
                  widget.clickedStudent.homePoints.toString(),
                  style: TextStyle(fontSize: 20),
                ),],
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'images/ranks/Beginner.png',
              height: 60,
              width: 60,
            ),
          ]
        ),
      ),
    );
  }
}
