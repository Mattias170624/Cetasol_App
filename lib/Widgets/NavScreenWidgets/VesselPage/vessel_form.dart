// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class VesselForm extends StatefulWidget {
  @override
  State<VesselForm> createState() => _VesselFormState();
}

class _VesselFormState extends State<VesselForm> {
  List<int> _finishedSteps = [];
  final keyList = <GlobalKey<FormState>>[
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  int _activeCurrentStep = 0;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  TextEditingController controller8 = TextEditingController();
  TextEditingController controller9 = TextEditingController();
  TextEditingController controller10 = TextEditingController();
  TextEditingController controller11 = TextEditingController();
  TextEditingController controller12 = TextEditingController();
  TextEditingController controller13 = TextEditingController();
  TextEditingController controller14 = TextEditingController();
  TextEditingController controller15 = TextEditingController();
  TextEditingController controller16 = TextEditingController();
  TextEditingController controller17 = TextEditingController();

  List<dynamic> engineTypeControllerList = [];

  String _radioButtonValue_1 = '8';
  String _radioButtonValue_2 = 'diesel';

  int _numberOfDrivelines = 0;

  Widget _drivelineExtraInputsBuilder(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: engineTypeControllerList[index],
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(),
          labelText: 'Driveline ${index + 1}',
          errorStyle: TextStyle(height: 0.5),
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        validator: (value) {
          if (value!.trim().isEmpty) return 'Required!';
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Theme(
        data: ThemeData(
          accentColor: Color.fromARGB(255, 255, 102, 37),
          colorScheme: ColorScheme.light(
            primary: Color.fromARGB(255, 255, 102, 37),
          ),
        ),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeCurrentStep,
          onStepContinue: () {
            if (!_finishedSteps.contains(_activeCurrentStep)) {
              _finishedSteps.add(_activeCurrentStep);
            }
            if (keyList[_activeCurrentStep].currentState!.validate()) {
              if (_activeCurrentStep < (stepList().length - 1)) {
                setState(() {
                  _activeCurrentStep += 1;
                });
              }
            }
          },
          onStepCancel: () {
            // if (_activeCurrentStep == 0) {
            //   return;
            // }

            // setState(() {
            //   _activeCurrentStep -= 1;
            // });
          },
          onStepTapped: (int index) {
            if (_finishedSteps.contains(index)) {
              setState(() {
                _activeCurrentStep = index;
              });
            }
          },
          steps: stepList(),
        ),
      ),
    );
  }

  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep == 0 ? StepState.editing : StepState.complete,
          isActive: _finishedSteps.contains(0),
          title: Text('General information'),
          content: Form(
            key: keyList[0],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Vessel name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller3,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'IMO number / MMSI',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Technical contact',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                TextFormField(
                  controller: controller4,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Full name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller5,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                //
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Planning contact',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                TextFormField(
                  controller: controller6,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Full name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controller7,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Display size best suited for your vessel',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -2),
                  title: Text('8 inch'),
                  leading: Radio(
                    value: '8',
                    groupValue: _radioButtonValue_1,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_1 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('12 inch'),
                  leading: Radio(
                    value: '12',
                    groupValue: _radioButtonValue_1,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_1 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('15 inch'),
                  leading: Radio(
                    value: '15',
                    groupValue: _radioButtonValue_1,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_1 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('18 inch'),
                  leading: Radio(
                    value: '18',
                    groupValue: _radioButtonValue_1,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_1 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('24 inch'),
                  leading: Radio(
                    value: '24',
                    groupValue: _radioButtonValue_1,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_1 = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeCurrentStep == 1
              ? StepState.editing
              : _finishedSteps.contains(1)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(1),
          title: Text('Engine information'),
          content: Form(
            key: keyList[1],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller8,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Number of drivelines',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  onChanged: (value) {
                    if (value.trim().isEmpty) return;
                    if (int.tryParse(value) == _numberOfDrivelines) return;
                    if (int.tryParse(value)! > 10) return;
                    setState(() {
                      _numberOfDrivelines = int.parse(controller8.value.text);
                    });

                    engineTypeControllerList.clear();
                    for (var i = 0;
                        i < int.parse(controller8.value.text);
                        i++) {
                      engineTypeControllerList.add(TextEditingController());
                    }
                  },
                  validator: (value) {
                    if (value == null) return null;
                    if (value.isEmpty) return 'Required';
                    if (int.tryParse(value)! > 10) {
                      return 'Too many drivelines!';
                    }
                    if (value.trim().isEmpty || int.tryParse(value) == 0) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: engineTypeControllerList.isNotEmpty,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5, top: 20),
                    child: Text('Engine type and model for..'),
                  ),
                ),
                for (var i = 0; i < _numberOfDrivelines; i++)
                  _drivelineExtraInputsBuilder(i),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Driveline type',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('Diesel'),
                  leading: Radio(
                    value: 'diesel',
                    groupValue: _radioButtonValue_2,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_2 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('Series hybrid'),
                  leading: Radio(
                    value: 'Series_hybrid',
                    groupValue: _radioButtonValue_2,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_2 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('Parallel hybrid'),
                  leading: Radio(
                    value: 'Parallel_hybrid',
                    groupValue: _radioButtonValue_2,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_2 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('Electric'),
                  leading: Radio(
                    value: 'Electric',
                    groupValue: _radioButtonValue_2,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_2 = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  horizontalTitleGap: 0,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text('Alternative fuels'),
                  leading: Radio(
                    value: 'Alternative_fuels',
                    groupValue: _radioButtonValue_2,
                    onChanged: (value) {
                      setState(() {
                        _radioButtonValue_2 = value.toString();
                      });
                    },
                  ),
                ),
                Text('data'),
              ],
            ),
          ),
        ),
        Step(
          state: _activeCurrentStep == 2
              ? StepState.editing
              : _finishedSteps.contains(2)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(2),
          title: Text('Address'),
          content: Form(
            key: keyList[2],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller6,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeCurrentStep == 3
              ? StepState.editing
              : _finishedSteps.contains(3)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(3),
          title: Text('Address'),
          content: Form(
            key: keyList[3],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller7,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  validator: MultiValidator(
                    [],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),

        // This is Step3 here we will display all the details
        // that are entered by the user
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 4,
          title: Text('Confirm'),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${controller1.text}'),
                Text('Email: ${controller2.text}'),
                Text('Password: ${controller3.text}'),
                Text('Address : ${controller4.text}'),
                Text('PinCode : ${controller5.text}'),
              ],
            ),
          ),
        )
      ];
}
