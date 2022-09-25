import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  String restorationId;

  RestorableDateTime selectedDate;

  TextEditingController dateController;

  Function()? selectDate;

  Function()? cancel;

  DateTextField(
      {Key? key,
      required this.restorationId,
      required this.selectedDate,
      required this.dateController,
      this.selectDate,
      this.cancel})
      : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  RestorableDateTime get _selectedDate => widget.selectedDate;

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.dateController.text =
            DateFormat("dd/MM/yyyy").format(_selectedDate.value);
        print(
            'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}');
      });
      widget.selectDate!();
    }
  }

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

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: widget.dateController,
      onTap: () {
        _restorableDatePickerRouteFuture.present();
      },
      decoration: InputDecoration(
          suffixIcon: InkWell(
        child: Icon(
          Icons.cancel,
          size: 30,
          color: Colors.red,
        ),
        onTap: () {
          widget.dateController.clear();
          widget.cancel!();
        },
      )),
    );
  }
}
