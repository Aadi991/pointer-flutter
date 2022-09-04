import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

class _LearnerHistoryState extends State<LearnerHistory> with RestorationMixin {
  Learner clickedLearner;
  TextEditingController dateController = TextEditingController();

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  _LearnerHistoryState(this.clickedLearner);

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dateController.text = DateFormat("dd/MM/yyyy").format(_selectedDate.value);
        print(
            'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {;
    return Scaffold(
      appBar: AppBar(
        title: Text("${clickedLearner.screenName}'s History"),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Container(
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
              child: Row(
                children: [
                  Text(
                    "Date:",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: dateController,
                      onTap: () {
                        _restorableDatePickerRouteFuture.present();
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
