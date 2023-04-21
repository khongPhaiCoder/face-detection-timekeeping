import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  final List<String> data;
  final String hintText;
  final double width;
  final Function() handleClick;
  const MyDropDown(
      {super.key,
      required this.data,
      required this.width,
      required this.hintText,
      required this.handleClick});
  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String? dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.hintText),
        Container(
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
                child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
               selectedItemBuilder: (BuildContext context) {
              return widget.data.take(5).map<Widget>((String item) {
                return Text(item);
              }).toList();
            },
              items: widget.data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
            )))
      ],
    );
  }
}
