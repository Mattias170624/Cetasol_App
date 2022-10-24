// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class TicketInputFields extends StatefulWidget {
  const TicketInputFields({super.key});

  @override
  State<TicketInputFields> createState() => _TicketInputFieldsState();
}

class _TicketInputFieldsState extends State<TicketInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _describeController = TextEditingController();
  bool showDropdownError = false;
  String? selectedValue;
  final List<String> items = [
    'Software related',
    'Hardware related',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20, top: 5),
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                  isExpanded: true,
                  hint: Text('Type of problem'),
                  items: items
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  ),
                  iconOnClick: Icon(
                    Icons.arrow_drop_up,
                    size: 25,
                  ),
                  iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
                  buttonElevation: 2,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownElevation: 2,
                ),
              ),
            ),
            Visibility(
              visible: showDropdownError,
              child: Container(
                margin: EdgeInsets.only(top: 5, left: 10),
                width: double.infinity,
                child: Text(
                  'Choose an option!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLength: 150,
              maxLines: 10,
              controller: _describeController,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                labelText: 'Describe your issue..',
                errorStyle: TextStyle(height: 0.5),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              validator: MultiValidator(
                [RequiredValidator(errorText: "Text can't be empty!")],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                  'After reviewing your ticket, we will contact you by the phone number associated with this account.'),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSendButton,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary,
                  fixedSize: Size(double.infinity, 40),
                ),
                child: Text(
                  'Send ticket',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSendButton() async {
    final validateResult = _formKey.currentState!.validate();

    selectedValue == null
        ? setState(() {
            showDropdownError = true;
          })
        : setState(() {
            showDropdownError = false;
          });

    if (validateResult && selectedValue != null) {
      final descriptionText = _describeController.value.text;
      if (await FirestoreDatabase()
          .sendTicket(selectedValue!, descriptionText)) {
        Navigator.pop(context);
      }
    }
  }
}
