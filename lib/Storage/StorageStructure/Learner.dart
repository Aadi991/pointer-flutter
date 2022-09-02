import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointer_v2/Utils.dart';

import '../cloudFirestoreControl.dart';
import 'ActionList.dart';
import 'ChildRank.dart';
import 'HistoryList.dart';
import 'Person.dart';

class Learner extends Person {
  ActionList actionList = new ActionList.empty();
  HistoryList historyList = new HistoryList.empty();
  String teachersID = "", parentsID = "", schoolID = "";
  ChildRank rank = ChildRank.None;
  int homePoints = 0;
  bool isBoy = true;

  Learner(
      String fullName,
      String screenName,
      String phoneNumber,
      int age,
      this.actionList,
      this.historyList,
      this.teachersID,
      this.parentsID,
      this.schoolID,
      this.rank,
      this.homePoints,
      this.isBoy)
      : super(fullName, screenName, phoneNumber, age);

  Learner.withOutLists(
      String fullName,
      String screenName,
      String phoneNumber,
      int age,
      this.teachersID,
      this.parentsID,
      this.schoolID,
      this.rank,
      this.homePoints,
      this.isBoy)
      : super(fullName, screenName, phoneNumber, age);

  factory Learner.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Learner.withOutLists(
        data?[CloudFirestoreControl.keyFullName],
        data?[CloudFirestoreControl.keyScreenName],
        data?[CloudFirestoreControl.keyPhoneNumber],
        data?[CloudFirestoreControl.keyAge],
        data?[CloudFirestoreControl.keyTeacherID],
        data?[CloudFirestoreControl.keyParentID],
        data?[CloudFirestoreControl.keySchoolID],
        Utils.stringToChildRank(data?[CloudFirestoreControl.keyHomeRanks]),
        data?[CloudFirestoreControl.keyHomePoints],
        data?[CloudFirestoreControl.keyIsBoy]);

  }

  factory Learner.fromMap(Map<String, dynamic> data) {
    return Learner.withOutLists(
        data[CloudFirestoreControl.keyFullName],
        data[CloudFirestoreControl.keyScreenName],
        data[CloudFirestoreControl.keyPhoneNumber],
        data[CloudFirestoreControl.keyAge],
        data[CloudFirestoreControl.keyTeacherID],
        data[CloudFirestoreControl.keyParentID],
        data[CloudFirestoreControl.keySchoolID],
        Utils.stringToChildRank(data[CloudFirestoreControl.keyHomeRanks]),
        data[CloudFirestoreControl.keyHomePoints],
        data[CloudFirestoreControl.keyIsBoy]
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      CloudFirestoreControl.keyFullName: fullName,
      CloudFirestoreControl.keyScreenName: screenName,
      CloudFirestoreControl.keyPhoneNumber: phoneNumber,
      CloudFirestoreControl.keyAge: age,
      CloudFirestoreControl.keyTeacherID: teachersID,
      CloudFirestoreControl.keyParentID: parentsID,
      CloudFirestoreControl.keySchoolID: schoolID,
      CloudFirestoreControl.keyHomeRanks: rank.toString(),
      CloudFirestoreControl.keyHomePoints: homePoints,
      CloudFirestoreControl.keyIsBoy: isBoy,
    };
  }

  Learner.empty():super.empty();
}
