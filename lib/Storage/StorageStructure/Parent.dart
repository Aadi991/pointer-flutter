import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pointer_v2/Storage/StorageStructure/LearnerList.dart';

import '../cloudFirestoreControl.dart';
import 'Person.dart';

class Parent extends Person {
  int pin = 0;
  LearnerList learnerList = LearnerList.empty();

  Parent(String fullName, String screenName, String phoneNumber, int age,
      this.pin, this.learnerList)
      : super(fullName, screenName, phoneNumber, age);

  Parent.withoutLists(
      String fullName, String screenName, String phoneNumber, int age, this.pin)
      : super(fullName, screenName, phoneNumber, age);

  factory Parent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Parent.withoutLists(
        data?[CloudFirestoreControl.keyFullName],
        data?[CloudFirestoreControl.keyScreenName],
        data?[CloudFirestoreControl.keyPhoneNumber],
        data?[CloudFirestoreControl.keyAge],
        data?[CloudFirestoreControl.keyPin]);
  }

  factory Parent.fromMap(
    Map<String, dynamic> data,
  ) {
    return Parent.withoutLists(
        data[CloudFirestoreControl.keyFullName],
        data[CloudFirestoreControl.keyScreenName],
        data[CloudFirestoreControl.keyPhoneNumber],
        data[CloudFirestoreControl.keyAge],
        data[CloudFirestoreControl.keyPin]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      CloudFirestoreControl.keyFullName: fullName,
      CloudFirestoreControl.keyScreenName: screenName,
      CloudFirestoreControl.keyPhoneNumber: phoneNumber,
      CloudFirestoreControl.keyAge: age,
      CloudFirestoreControl.keyPin: pin
    };
  }
}
