import 'package:flutter/material.dart';

class ViewParentData extends StatelessWidget {
  TextEditingController screenNameController;
  TextEditingController phoneNumberController;
  TextEditingController ageController;
  TextEditingController parentPinController;
  int index;

  ViewParentData(
      {Key? key,
        required this.screenNameController,
        required this.phoneNumberController,
        required this.ageController,
        required this.parentPinController,
        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
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
          Expanded(
            child: TextField(
              controller: screenNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Screen Name",
              ),
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
          Expanded(
            child: TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone Number",
              ),
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
          Expanded(
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Age",
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
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
          Expanded(
            child: TextField(
              controller: parentPinController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Parent Pin",
              ),
            ),
          ),
        ],
      )
    ],);
  }
}
