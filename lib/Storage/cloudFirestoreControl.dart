import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointer_v2/Storage/StorageStructure/Action.dart';
import 'package:pointer_v2/Storage/StorageStructure/ActionList.dart';
import 'package:pointer_v2/Storage/StorageStructure/History.dart';
import 'package:pointer_v2/Storage/StorageStructure/HistoryList.dart';
import 'package:pointer_v2/Storage/StorageStructure/Learner.dart';
import 'package:pointer_v2/Storage/StorageStructure/LearnerList.dart';

import 'StorageStructure/Parent.dart';

class CloudFirestoreControl {
  FirebaseFirestore db = FirebaseFirestore.instance;
  static const String keyFullName = "Full Name";
  static const String keyScreenName = "Screen Name";
  static const String keyPhoneNumber = "Phone Number";
  static const String keyAge = "Age";
  static const String keyStudentRanks = "Student Rank";
  static const String keyHomeRanks = "Rank";
  static const String keyTeacherID = "Teacher ID";
  static const String keyParentID = "Parent ID";
  static const String keySchoolID = "School ID";
  static const String keyIsStudent = "Is a Student?";
  static const String keySchoolPoints = "School Points";
  static const String keyHomePoints = "Home Points";
  static const String keyPin = "Parent Pin";
  static const String keyReason = "Reason";
  static const String keyValue = "Value";
  static const String keyTimestamp = "Timestamp";
  static const String keyAskParentPin = "Ask Parent Pin";
  static const String keyTeacherRef = "Teacher Reference";
  static const String keySchoolRef = "School Reference";
  static const String keyIsBoy = "Is a Boy?";

  void setParent(Parent toSave) {
    db
        .collection("Parents")
        .doc(toSave.phoneNumber)
        .withConverter<Parent>(
            fromFirestore: Parent.fromFirestore,
            toFirestore: (model, _) => model.toFirestore())
        .set(toSave);
    if (toSave.learnerList != null) setLearnerList(toSave.learnerList);
  }

  void updateParent(Parent old, Parent toSave) {
    if (toSave.phoneNumber != old.phoneNumber) {
      db
          .collection("Parents")
          .doc(toSave.phoneNumber)
          .withConverter<Parent>(
              fromFirestore: Parent.fromFirestore,
              toFirestore: (model, _) => model.toFirestore())
          .set(toSave);
      db.collection("Parents").doc(old.phoneNumber).delete();
    } else {
      db
          .collection("Parents")
          .doc(toSave.phoneNumber)
          .update(toSave.toFirestore());
    }
  }

  Future<Parent> getParent(String phoneNumber) async {
    Parent got = (await db
            .collection("Parents")
            .doc(phoneNumber)
            .withConverter<Parent>(
                fromFirestore: Parent.fromFirestore,
                toFirestore: (model, _) => model.toFirestore())
            .get())
        .data()!;
    got.learnerList = await getLearnerList(got.phoneNumber);
    return got;
  }

  void setLearnerList(LearnerList learnerList) {
    for (final learner in learnerList.learnerList) {
      setLearner(learner);
    }
  }

  Future<LearnerList> getLearnerList(String phoneNo) async {
    LearnerList got = LearnerList.empty();
    QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection("Parents")
        .doc(phoneNo)
        .collection("Learners")
        .get();
    if (snap.docs.isEmpty) {
      return LearnerList.empty();
    } else {
      final allData = snap.docs.map((doc) => doc.data()).toList();
      for (final e in allData) {
        Map<String, dynamic> data = e;
        got.learnerList.add(Learner.fromMap(data));
      }
      return got;
    }
  }

  void setLearner(Learner toSave) {
    db
        .collection("Parents")
        .doc(toSave.parentsID)
        .collection("Learners")
        .doc(toSave.screenName)
        .withConverter<Learner>(
            fromFirestore: Learner.fromFirestore,
            toFirestore: (model, _) => model.toFirestore())
        .set(toSave);
    setActionList(toSave.actionList);
    setHistoryList(toSave.historyList);
  }

  void updateLearner(Learner toSave, Learner old) {
    if ((toSave.parentsID != old.parentsID) ||
        (toSave.screenName != old.screenName)) {
      db
          .collection("Parents")
          .doc(old.parentsID)
          .collection("Learners")
          .doc(old.screenName)
          .delete();
      db
          .collection("Parents")
          .doc(toSave.parentsID)
          .collection("Learners")
          .doc(toSave.screenName)
          .withConverter<Learner>(
              fromFirestore: Learner.fromFirestore,
              toFirestore: (model, _) => model.toFirestore())
          .set(toSave);
    }else{
      db
          .collection("Parents")
          .doc(toSave.parentsID)
          .collection("Learners")
          .doc(toSave.screenName)
          .update(toSave.toFirestore());
    }
  }

  Future<Learner> getLearner(String parentsID, String screenName) async {
    Learner got = (await db
            .collection("Parents")
            .doc(parentsID)
            .collection("Learners")
            .doc(screenName)
            .withConverter<Learner>(
                fromFirestore: Learner.fromFirestore,
                toFirestore: (model, _) => model.toFirestore())
            .get())
        .data()!;
    got.actionList = await getActionList(parentsID, screenName);
    got.historyList = await getHistoryList(parentsID, screenName);
    return got;
  }

  void setActionList(ActionList toSave) {
    for (final action in toSave.actionList) {
      setAction(action);
    }
  }

  Future<ActionList> getActionList(
      String parentID, String learnerScreenName) async {
    ActionList got = ActionList.empty();
    /*print("Getting action list");
    print("ParentID $parentID");
    print("Screen Name $learnerScreenName");
    print("Path ${db
        .collection("Parents")
        .doc(parentID)
        .collection("Learners")
        .doc(learnerScreenName)
        .collection("Actions").path}");*/
    QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection("Parents")
        .doc(parentID)
        .collection("Learners")
        .doc(learnerScreenName)
        .collection("Actions")
        .get().timeout(Duration(seconds: 30));
    print(snap.docs.isEmpty);
    if (snap.docs.isEmpty) {
      return ActionList.empty();
    } else {
      final allData = snap.docs.map((doc) => doc.data()).toList();
      for (final e in allData) {
        Map<String, dynamic> data = e;
        got.actionList.add(Action.fromMap(data));
      }
      return got;
    }
  }

  void setAction(Action toSave) {
    db
        .collection("Parents")
        .doc(toSave.parentID)
        .collection("Learners")
        .doc(toSave.learnerScreenName)
        .collection("Actions")
        .doc(toSave.reason)
        .withConverter<Action>(
            fromFirestore: Action.fromFirestore,
            toFirestore: (model, _) => model.toFirestore())
        .set(toSave);
  }

  Future<Action> getAction(
      String parentID, String learnerScreenName, String reason) async {
    return (await db
            .collection("Parents")
            .doc(parentID)
            .collection("Learners")
            .doc(learnerScreenName)
            .collection("Actions")
            .doc(reason)
            .withConverter<Action>(
                fromFirestore: Action.fromFirestore,
                toFirestore: (model, _) => model.toFirestore())
            .get())
        .data()!;
  }

  void setHistoryList(HistoryList toSave) {
    for (var element in toSave.historyList) {
      setHistory(element);
    }
  }

  Future<HistoryList> getHistoryList(
      String parentID, String learnerScreenName) async {
    HistoryList got = HistoryList.empty();
    QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection("Parents")
        .doc(parentID)
        .collection("Learners")
        .doc(learnerScreenName)
        .collection("History")
        .get();
    final allData = snap.docs.map((doc) => doc.data()).toList();
    for (final e in allData) {
      Map<String, dynamic> data = e;
      got.historyList.add(History.fromMap(data));
    }
    return got;
  }

  void setHistory(History toSave) {
    db
        .collection("Parents")
        .doc(toSave.parentID)
        .collection("Learners")
        .doc(toSave.learnerScreenName)
        .collection("History")
        .doc(toSave.timestamp)
        .withConverter<History>(
            fromFirestore: History.fromFirestore,
            toFirestore: (model, _) => model.toFirestore())
        .set(toSave);
  }

  Future<History> getHistory(
      String parentID, String learnerScreenName, String timestamp) async {
    return (await db
            .collection("Parents")
            .doc(parentID)
            .collection("Learners")
            .doc(learnerScreenName)
            .collection("History")
            .doc(timestamp)
            .withConverter<History>(
                fromFirestore: History.fromFirestore,
                toFirestore: (model, _) => model.toFirestore())
            .get())
        .data()!;
  }

  Future<bool> checkIfDocumentExists(String path) async {
    try {
      DocumentSnapshot snap = await db.doc(path).get();
      return snap.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
