import 'package:cloud_firestore/cloud_firestore.dart';

import '../cloudFirestoreControl.dart';

class Action{
  String reason = "";
  int points = 0;
  String parentID = "";
  String learnerScreenName = "";

  Action(this.reason, this.points);


  Action.full(this.reason, this.points, this.parentID, this.learnerScreenName);

  Action.empty();

  factory Action.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Action(data?[CloudFirestoreControl.keyReason],
        data?[CloudFirestoreControl.keyValue]);
  }

  factory Action.fromMap(Map<String, dynamic> data,) {
    return Action(
        data[CloudFirestoreControl.keyReason],
        data[CloudFirestoreControl.keyValue]
    );
  }

  Map<String,dynamic> toFirestore() {
    return {
      CloudFirestoreControl.keyReason: reason,
      CloudFirestoreControl.keyValue: points,
    };
  }
}