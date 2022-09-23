import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeTextField extends StatefulWidget {
  String restorationId;

  RestorableDateTime selectedDate;

  TextEditingController startDateController;
  TextEditingController endDateController;

  Function()? selectDate;

  bool isStartDate;

  DateRangeTextField(
      {Key? key,
      required this.restorationId,
      required this.selectedDate,
      required this.startDateController,
      required this.endDateController,
      required this.isStartDate,
      this.selectDate})
      : super(key: key);

  @override
  State<DateRangeTextField> createState() => _DateRangeTextFieldState();
}

class _DateRangeTextFieldState extends State<DateRangeTextField> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  RestorableDateTime get _selectedDate => widget.selectedDate;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate = RestorableDateTimeN(DateTime.now());
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
        widget.startDateController.text = DateFormat("dd/MM/yyyy").format(_startDate.value!);
        widget.endDateController.text = DateFormat("dd/MM/yyyy").format(_endDate.value!);
      });
      widget.selectDate!();
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(2021),
          currentDate: DateTime(2021, 1, 25),
          lastDate: DateTime(2023),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: widget.isStartDate? widget.startDateController : widget.endDateController,
      onTap: () {
        _restorableDateRangePickerRouteFuture.present();
      },
    );
  }
}
