import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../cloudFirestoreControl.dart';

class History {
  String timestamp = "",
      reason = "",
      date = "",
      parentID = "",
      learnerScreenName = "";
  int points = 0;

  History(this.reason, this.timestamp, this.points);


  History.full(this.timestamp, this.reason, this.date, this.parentID,
      this.learnerScreenName, this.points);

  History.empty();

  History.calculateTimestamp(String reason, int points) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat("HH:mm:ss:SSSS dd-MM-yyyy");
    timestamp = formatter.format(now);
  }

  factory History.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return History(
        data?[CloudFirestoreControl.keyTimestamp],
        data?[CloudFirestoreControl.keyReason],
        data?[CloudFirestoreControl.keyValue]);
  }

  factory History.fromMap(
    Map<String, dynamic> data,
  ) {
    return History(
        data[CloudFirestoreControl.keyTimestamp],
        data[CloudFirestoreControl.keyReason],
        data[CloudFirestoreControl.keyValue]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      CloudFirestoreControl.keyTimestamp: timestamp,
      CloudFirestoreControl.keyReason: reason,
      CloudFirestoreControl.keyValue: points,
    };
  }
}
