import 'package:flutter/material.dart';

class GetParentData extends StatelessWidget {
  TextEditingController screenNameController;
  TextEditingController phoneNumberController;
  TextEditingController ageController;
  TextEditingController fullNameController;
  TextEditingController parentPinController;
  int index;

  GetParentData(
      {Key? key,
      required this.screenNameController,
      required this.phoneNumberController,
      required this.ageController,
      required this.fullNameController,
      required this.parentPinController,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Screen Name:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              screenNameController.value == null
                  ? "Unknown"
                  : screenNameController.value.text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Phone Number:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              phoneNumberController.value == null
                  ? "Unknown"
                  : phoneNumberController.value.text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Age:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              ageController.value == null
                  ? "Unknown"
                  : ageController.value.text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Parent Pin:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              parentPinController.value == null
                  ? "Unknown"
                  : parentPinController.value.text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
