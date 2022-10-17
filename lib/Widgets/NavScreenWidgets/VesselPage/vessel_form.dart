// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/Models/vessel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class VesselForm extends StatefulWidget {
  @override
  State<VesselForm> createState() => _VesselFormState();
}

class _VesselFormState extends State<VesselForm> {
  final formKeyList = <GlobalKey<FormState>>[
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  int _activeCurrentStep = 0;
  final List<int> _finishedSteps = [];
  final Map<String, TextEditingController> textControllerList = {};
  final Map<String, String> radioButtonValuesList = {
    'display_size': '',
    'driveline_type': '',
    'fuel_flow_signal': '',
    'fuel_flow_installed': '',
    'fuel_flow_signal_type': '',
    'wire_engine_room_or_bridge': '',
    'engine_speed_torque_signals': '',
    'tank_sensor': '',
    'connect_power_generation_to_system': '',
    'extra_fuel_flow_signal': '',
    'extra_fuel_flow_signal_type': '',
    'extra_wire_engine_room_or_bridge': '',
    'extra_fuel_flow_installed': '',
    'extra_engine_speed_torque_signals': '',
    'have_gps': '',
    'gps_network': '',
    'have_compass': '',
    'compass_network': '',
    'know_how_to_read_power_consumption': '',
    'anything_else_you_want_to_contact': '',
  };

  int _numOfdrivelineInfoBoxes = 0;
  bool showImage1Error = false;
  bool showImage2Error = false;
  bool showImage3Error = false;
  bool _showDuplicateVesselError = false;

  XFile? imageData1;
  XFile? imageData2;
  XFile? imageData3;

  void _handleFormComplete() async {
    var drivelineInfoList = [];
    var extraDescription = (textControllerList['final_extra_description']!
                .text
                .isNotEmpty &&
            radioButtonValuesList['anything_else_you_want_to_contact'] == 'yes')
        ? textControllerList['final_extra_description']!.text
        : null;
    final fuelFlowSignal = radioButtonValuesList['fuel_flow_signal'];
    var fuelFlowSignalType = fuelFlowSignal == 'yes'
        ? radioButtonValuesList['fuel_flow_signal_type']
        : null;
    var wiresLocation = fuelFlowSignal == 'yes'
        ? radioButtonValuesList['wire_engine_room_or_bridge']
        : null;
    var fuelFlowInstalled = fuelFlowSignal == 'no'
        ? radioButtonValuesList['fuel_flow_installed']
        : null;
    var engineSpeedAndTorque = fuelFlowSignal == 'no'
        ? radioButtonValuesList['engine_speed_torque_signals']
        : null;
    var connectExtra =
        radioButtonValuesList['connect_power_generation_to_system'];
    var extraFuelFlowSignal = connectExtra == 'yes'
        ? radioButtonValuesList['extra_fuel_flow_signal']
        : null;
    var extraFueldFlowSignalType = connectExtra == 'yes'
        ? radioButtonValuesList['extra_fuel_flow_signal_type']
        : null;
    var extraWiresLocation = connectExtra == 'yes'
        ? radioButtonValuesList['extra_location_of_wires']
        : null;
    var extraFuelFlowInstalled = connectExtra == 'no'
        ? radioButtonValuesList['extra_fuel_flow_installed']
        : null;
    var extraSpeedAndTorque = connectExtra == 'no'
        ? radioButtonValuesList['extra_engine_speed_and_torque_signals']
        : null;
    var gpsNetwork = radioButtonValuesList['have_gps'] == 'yes'
        ? radioButtonValuesList['gps_network']
        : null;

    var compassNetwork = radioButtonValuesList['have_compass'] == 'yes'
        ? radioButtonValuesList['compass_network']
        : null;

    textControllerList.forEach((key, value) {
      if (key.startsWith('driveline_')) {
        drivelineInfoList.add(value.text);
      }
    });

    var vesselObject = VesselModel(
      textControllerList['company_name']!.text,
      textControllerList['vessel_name']!.text,
      textControllerList['imo_number']!.text,
      textControllerList['technical_full_name']!.text,
      textControllerList['technical_email']!.text,
      textControllerList['planning_full_name']!.text,
      textControllerList['planning_email']!.text,
      textControllerList['number_of_drivelines']!.text,
      drivelineInfoList,
      radioButtonValuesList['driveline_type']!,
      imageData1!,
      imageData2!,
      imageData3!,
      radioButtonValuesList['tank_sensor']!,
      radioButtonValuesList['fuel_flow_signal'],
      fuelFlowSignalType,
      wiresLocation,
      fuelFlowInstalled,
      engineSpeedAndTorque,
      radioButtonValuesList['connect_power_generation_to_system']!,
      extraFuelFlowSignal,
      extraFueldFlowSignalType,
      extraWiresLocation,
      extraFuelFlowInstalled,
      extraSpeedAndTorque,
      radioButtonValuesList['have_gps']!,
      gpsNetwork,
      radioButtonValuesList['have_compass']!,
      compassNetwork,
      extraDescription,
      radioButtonValuesList['display_size']!,
    );

    if (await FirestoreDatabase().addNewVessel(vesselObject.createParsedList)) {
      Navigator.pop(context);
    } else {
      setState(() {
        _showDuplicateVesselError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Theme(
        data: ThemeData(
          accentColor: Theme.of(context).colorScheme.onPrimary,
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeCurrentStep,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Column(
              children: [
                Divider(
                  thickness: 1,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(_activeCurrentStep == stepList().length - 1
                            ? 'Finish'
                            : 'Next'),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: Text('Back'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          onStepContinue: () {
            if (!_finishedSteps.contains(_activeCurrentStep)) {
              _finishedSteps.add(_activeCurrentStep);
            }

            // Check if we reached the end of steps
            if (_activeCurrentStep == stepList().length - 1) {
              _handleFormComplete();
              return;
            }

            if (formKeyList[_activeCurrentStep].currentState!.validate()) {
              // Check if all image data contains a value
              if (_activeCurrentStep == 1) {
                if (imageData1 == null) {
                  setState(() {
                    showImage1Error = true;
                  });
                  return;
                }
                showImage1Error = false;
              }

              if (_activeCurrentStep == 2) {
                if (imageData2 == null) {
                  setState(() {
                    showImage2Error = true;
                  });
                  return;
                }
                if (imageData3 == null) {
                  setState(() {
                    showImage3Error = true;
                  });
                  return;
                }
                showImage2Error = false;
                showImage3Error = false;
              }

              if (_activeCurrentStep < (stepList().length - 1)) {
                setState(() {
                  _activeCurrentStep += 1;
                });
              }
            }
          },
          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
              _showDuplicateVesselError = false;
            });
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
            key: formKeyList[0],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _createTextController('company_name'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('vessel_name'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('imo_number'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Technical contact',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('technical_full_name'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('technical_email'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Planning contact',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('planning_full_name'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _createTextController('planning_email'),
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
                    [RequiredValidator(errorText: 'Required!')],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Display size best suited for your vessel',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text('8 inch'),
                          leading: Radio(
                            value: '8_inch',
                            groupValue: radioButtonValuesList['display_size'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['display_size'] =
                                      value.toString();
                                }
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
                            groupValue: radioButtonValuesList['display_size'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['display_size'] =
                                      value.toString();
                                }
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
                            groupValue: radioButtonValuesList['display_size'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['display_size'] =
                                      value.toString();
                                }
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
                            groupValue: radioButtonValuesList['display_size'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['display_size'] =
                                      value.toString();
                                }
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
                            groupValue: radioButtonValuesList['display_size'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['display_size'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Please choose an option!';
                    }
                    return null;
                  },
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
          title: Text('Driveline information'),
          content: Form(
            key: formKeyList[1],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _createTextController('number_of_drivelines'),
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
                  onChanged: (drivelineText) {
                    if (drivelineText.trim().isEmpty) return;
                    if (int.tryParse(drivelineText) ==
                        _numOfdrivelineInfoBoxes) {
                      return;
                    }
                    if (int.tryParse(drivelineText)! > 10) return;
                    var getNumOfDrivelines = int.tryParse(
                        textControllerList['number_of_drivelines']!.text);

                    // Removing old controllers if user decided to change
                    // The number of drivelines
                    textControllerList.removeWhere(
                        (key, value) => key.contains('driveline_'));

                    setState(() {
                      _numOfdrivelineInfoBoxes = getNumOfDrivelines!;
                    });
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
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _numOfdrivelineInfoBoxes > 0,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text('Engine type and model for..'),
                  ),
                ),
                for (var i = 0; i < _numOfdrivelineInfoBoxes; i++)
                  _drivelineExtraInputsBuilder(i),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text('Picture of manufacturing label'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery, 0);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.drive_folder_upload_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Pick from gallery')
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.camera, 0);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Use camera'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      'Current selected image: ${imageData1 == null ? 'No image selected' : '\n${imageData1!.path}'}'),
                ),
                Visibility(
                  visible: showImage1Error,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Please select an image!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
                SizedBox(
                  height: 5,
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text('Diesel'),
                          leading: Radio(
                            value: 'diesel',
                            groupValue: radioButtonValuesList['driveline_type'],
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['driveline_type'] =
                                      value.toString();
                                }
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
                            value: 'series_hybrid',
                            groupValue: radioButtonValuesList['driveline_type'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['driveline_type'] =
                                      value.toString();
                                }
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
                            value: 'parallel_hybrid',
                            groupValue: radioButtonValuesList['driveline_type'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['driveline_type'] =
                                      value.toString();
                                }
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
                            value: 'electric',
                            groupValue: radioButtonValuesList['driveline_type'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['driveline_type'] =
                                      value.toString();
                                }
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
                            value: 'alternative_fuels',
                            groupValue: radioButtonValuesList['driveline_type'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['driveline_type'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Please choose an option!';
                    }
                    return null;
                  },
                ),
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
          title: Text('Diagram information'),
          content: Form(
            key: formKeyList[2],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text('Picture of wiring diagram drivelines'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery, 1);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.drive_folder_upload_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Pick from gallery')
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.camera, 1);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_camera_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Use camera')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      'Current selected image: ${imageData2 == null ? '' : '\n${imageData2!.path}'}'),
                ),
                Visibility(
                  visible: showImage2Error,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Please select an image!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text('Picture of wiring diagram navigation system'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery, 2);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.drive_folder_upload_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Pick from gallery')
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.camera, 2);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_camera_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Use camera')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      'Current selected image: ${imageData3 == null ? '' : '\n${imageData3!.path}'}'),
                ),
                Visibility(
                  visible: showImage3Error,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Please select an image!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
          title: Text('Engine information'),
          content: Form(
            key: formKeyList[3],
            child: Column(
              children: [
                Column(
                  children: [
                    Visibility(
                      visible:
                          radioButtonValuesList['driveline_type'] != 'electric',
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                                'Does your engine have a fuel flow signal?'),
                          ),
                          FormField(
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                children: [
                                  state.hasError
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.errorText!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        )
                                      : Container(),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text('Yes'),
                                    leading: Radio(
                                      value: 'yes',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text('No'),
                                    leading: Radio(
                                      value: 'no',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("I don't know"),
                                    leading: Radio(
                                      value: 'i_dont_know',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'Required!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          radioButtonValuesList['fuel_flow_signal'] == 'yes',
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text('Is it based on...'),
                          ),
                          FormField(
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                children: [
                                  state.hasError
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.errorText!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        )
                                      : Container(),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("CAN J1939"),
                                    leading: Radio(
                                      value: 'canj1939',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Modbus"),
                                    leading: Radio(
                                      value: 'modbus',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("NMEA2000"),
                                    leading: Radio(
                                      value: 'nmea2000',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("NMEA0183"),
                                    leading: Radio(
                                      value: 'nmea0183',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Other"),
                                    leading: Radio(
                                      value: 'other',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("I don't know"),
                                    leading: Radio(
                                      value: 'i_dont_know',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_signal_type'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_signal_type'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'Required!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                                'Are those wires available in the engine room, or in the bridge'),
                          ),
                          FormField(
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                children: [
                                  state.hasError
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.errorText!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        )
                                      : Container(),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Engine room"),
                                    leading: Radio(
                                      value: 'engine',
                                      groupValue: radioButtonValuesList[
                                          'wire_engine_room_or_bridge'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'wire_engine_room_or_bridge'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Bridge"),
                                    leading: Radio(
                                      value: 'bridge',
                                      groupValue: radioButtonValuesList[
                                          'wire_engine_room_or_bridge'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'wire_engine_room_or_bridge'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'Required!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          radioButtonValuesList['fuel_flow_signal'] == 'no',
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text('Do you have fuel flow installed?'),
                          ),
                          FormField(
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                children: [
                                  state.hasError
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.errorText!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        )
                                      : Container(),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: 'yes',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_installed'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_installed'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("No"),
                                    leading: Radio(
                                      value: 'no',
                                      groupValue: radioButtonValuesList[
                                          'fuel_flow_installed'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'fuel_flow_installed'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'Required!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                                'Does your engine have speed and torque signals?'),
                          ),
                          FormField(
                            builder: (FormFieldState<bool> state) {
                              return Column(
                                children: [
                                  state.hasError
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            state.errorText!,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        )
                                      : Container(),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("Yes"),
                                    leading: Radio(
                                      value: 'yes',
                                      groupValue: radioButtonValuesList[
                                          'engine_speed_torque_signals'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'engine_speed_torque_signals'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("No"),
                                    leading: Radio(
                                      value: 'no',
                                      groupValue: radioButtonValuesList[
                                          'engine_speed_torque_signals'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'engine_speed_torque_signals'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    horizontalTitleGap: 0,
                                    visualDensity: VisualDensity(vertical: -4),
                                    title: Text("I dont't know"),
                                    leading: Radio(
                                      value: 'i_dont_know',
                                      groupValue: radioButtonValuesList[
                                          'engine_speed_torque_signals'],
                                      onChanged: (value) {
                                        setState(() {
                                          state.setValue(true);
                                          if (value != null) {
                                            radioButtonValuesList[
                                                    'engine_speed_torque_signals'] =
                                                value.toString();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'Required!';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text('Do you have a tank sensor?'),
                    ),
                    FormField(
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          children: [
                            state.hasError
                                ? SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      state.errorText!,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                  )
                                : Container(),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              horizontalTitleGap: 0,
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text("Yes"),
                              leading: Radio(
                                value: 'yes',
                                groupValue:
                                    radioButtonValuesList['tank_sensor'],
                                onChanged: (value) {
                                  setState(() {
                                    state.setValue(true);
                                    if (value != null) {
                                      radioButtonValuesList['tank_sensor'] =
                                          value.toString();
                                    }
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              horizontalTitleGap: 0,
                              visualDensity: VisualDensity(vertical: -4),
                              title: Text("No"),
                              leading: Radio(
                                value: 'no',
                                groupValue:
                                    radioButtonValuesList['tank_sensor'],
                                onChanged: (value) {
                                  setState(() {
                                    state.setValue(true);
                                    if (value != null) {
                                      radioButtonValuesList['tank_sensor'] =
                                          value.toString();
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      validator: (value) {
                        if (value != true) {
                          return 'Required!';
                        }
                        return null;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Step(
          state: _activeCurrentStep == 4
              ? StepState.editing
              : _finishedSteps.contains(4)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(4),
          title: Text('Power generation system'),
          content: Form(
            key: formKeyList[4],
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      'Do you want to connect your power generation to the system as well?'),
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("No"),
                          leading: Radio(
                            value: 'no',
                            groupValue: radioButtonValuesList[
                                'connect_power_generation_to_system'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList[
                                          'connect_power_generation_to_system'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("Yes"),
                          leading: Radio(
                            value: 'yes',
                            groupValue: radioButtonValuesList[
                                'connect_power_generation_to_system'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList[
                                          'connect_power_generation_to_system'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("I don't know"),
                          leading: Radio(
                            value: 'i_dont_know',
                            groupValue: radioButtonValuesList[
                                'connect_power_generation_to_system'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList[
                                          'connect_power_generation_to_system'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Required!';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: (radioButtonValuesList[
                              'connect_power_generation_to_system'] ==
                          'yes' &&
                      radioButtonValuesList['driveline_type'] != 'electric'),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:
                            Text('Does your engine have a fuel flow signal?'),
                      ),
                      FormField(
                        builder: (FormFieldState<bool> state) {
                          return Column(
                            children: [
                              state.hasError
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text('Yes'),
                                leading: Radio(
                                  value: 'yes',
                                  groupValue: radioButtonValuesList[
                                      'extra_fuel_flow_signal'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'extra_fuel_flow_signal'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text('No'),
                                leading: Radio(
                                  value: 'no',
                                  groupValue: radioButtonValuesList[
                                      'extra_fuel_flow_signal'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'extra_fuel_flow_signal'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("I don't know"),
                                leading: Radio(
                                  value: 'i_dont_know',
                                  groupValue: radioButtonValuesList[
                                      'extra_fuel_flow_signal'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'extra_fuel_flow_signal'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (value != true) {
                            return 'Required!';
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        visible:
                            radioButtonValuesList['extra_fuel_flow_signal'] ==
                                'yes',
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text('Is it based on...'),
                            ),
                            FormField(
                              builder: (FormFieldState<bool> state) {
                                return Column(
                                  children: [
                                    state.hasError
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              state.errorText!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                          )
                                        : Container(),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("CAN J1939"),
                                      leading: Radio(
                                        value: 'canj1939',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Modbus"),
                                      leading: Radio(
                                        value: 'modbus',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("NMEA2000"),
                                      leading: Radio(
                                        value: 'nmea2000',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("NMEA0183"),
                                      leading: Radio(
                                        value: 'nmea0183',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Other"),
                                      leading: Radio(
                                        value: 'other',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("I don't know"),
                                      leading: Radio(
                                        value: 'i_dont_know',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_signal_type'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_signal_type'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: (value) {
                                if (value != true) {
                                  return 'Required!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                  'Are those wires available in the engine room, or in the bridge'),
                            ),
                            FormField(
                              builder: (FormFieldState<bool> state) {
                                return Column(
                                  children: [
                                    state.hasError
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              state.errorText!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                          )
                                        : Container(),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Engine room"),
                                      leading: Radio(
                                        value: 'engine',
                                        groupValue: radioButtonValuesList[
                                            'extra_wire_engine_room_or_bridge'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_wire_engine_room_or_bridge'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Bridge"),
                                      leading: Radio(
                                        value: 'bridge',
                                        groupValue: radioButtonValuesList[
                                            'extra_wire_engine_room_or_bridge'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_wire_engine_room_or_bridge'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: (value) {
                                if (value != true) {
                                  return 'Required!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            radioButtonValuesList['extra_fuel_flow_signal'] ==
                                'no',
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text('Do you have fuel flow installed?'),
                            ),
                            FormField(
                              builder: (FormFieldState<bool> state) {
                                return Column(
                                  children: [
                                    state.hasError
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              state.errorText!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                          )
                                        : Container(),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Yes"),
                                      leading: Radio(
                                        value: 'yes',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_installed'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_installed'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("No"),
                                      leading: Radio(
                                        value: 'no',
                                        groupValue: radioButtonValuesList[
                                            'extra_fuel_flow_installed'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_fuel_flow_installed'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: (value) {
                                if (value != true) {
                                  return 'Required!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                  'Does your engine have speed and torque signals?'),
                            ),
                            FormField(
                              builder: (FormFieldState<bool> state) {
                                return Column(
                                  children: [
                                    state.hasError
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              state.errorText!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                          )
                                        : Container(),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("Yes"),
                                      leading: Radio(
                                        value: 'yes',
                                        groupValue: radioButtonValuesList[
                                            'extra_engine_speed_torque_signals'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_engine_speed_torque_signals'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("No"),
                                      leading: Radio(
                                        value: 'no',
                                        groupValue: radioButtonValuesList[
                                            'extra_engine_speed_torque_signals'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_engine_speed_torque_signals'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      horizontalTitleGap: 0,
                                      visualDensity:
                                          VisualDensity(vertical: -4),
                                      title: Text("I dont't know"),
                                      leading: Radio(
                                        value: 'i_dont_know',
                                        groupValue: radioButtonValuesList[
                                            'extra_engine_speed_torque_signals'],
                                        onChanged: (value) {
                                          setState(() {
                                            state.setValue(true);
                                            if (value != null) {
                                              radioButtonValuesList[
                                                      'extra_engine_speed_torque_signals'] =
                                                  value.toString();
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              validator: (value) {
                                if (value != true) {
                                  return 'Required!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeCurrentStep == 5
              ? StepState.editing
              : _finishedSteps.contains(5)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(5),
          title: Text('Navigation systems'),
          content: Form(
            key: formKeyList[5],
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text('Do you have a GPS?'),
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("Yes"),
                          leading: Radio(
                            value: 'yes',
                            groupValue: radioButtonValuesList['have_gps'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['have_gps'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("No"),
                          leading: Radio(
                            value: 'no',
                            groupValue: radioButtonValuesList['have_gps'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['have_gps'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Required!';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: radioButtonValuesList['have_gps'] == 'yes',
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5, top: 10),
                        child: Text('What network is your GPS on?'),
                      ),
                      FormField(
                        builder: (FormFieldState<bool> state) {
                          return Column(
                            children: [
                              state.hasError
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA2000"),
                                leading: Radio(
                                  value: 'nmea2000',
                                  groupValue:
                                      radioButtonValuesList['gps_network'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList['gps_network'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA0183"),
                                leading: Radio(
                                  value: 'nmea0183',
                                  groupValue:
                                      radioButtonValuesList['gps_network'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList['gps_network'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (value != true) {
                            return 'Required!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text('Do you have a compass?'),
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("Yes"),
                          leading: Radio(
                            value: 'yes',
                            groupValue: radioButtonValuesList['have_compass'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['have_compass'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("No"),
                          leading: Radio(
                            value: 'no',
                            groupValue: radioButtonValuesList['have_compass'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList['have_compass'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Required!';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: radioButtonValuesList['have_compass'] == 'yes',
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5, top: 10),
                        child: Text('What network is your compass on?'),
                      ),
                      FormField(
                        builder: (FormFieldState<bool> state) {
                          return Column(
                            children: [
                              state.hasError
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA2000"),
                                leading: Radio(
                                  value: 'nmea2000',
                                  groupValue:
                                      radioButtonValuesList['compass_network'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'compass_network'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA0183"),
                                leading: Radio(
                                  value: 'nmea0183',
                                  groupValue:
                                      radioButtonValuesList['compass_network'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'compass_network'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (value != true) {
                            return 'Required!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //
        //
        //
        Step(
          state: _activeCurrentStep == 6
              ? StepState.editing
              : _finishedSteps.contains(6)
                  ? StepState.complete
                  : StepState.editing,
          isActive: _finishedSteps.contains(6),
          title: Text('Other connections'),
          content: Form(
            key: formKeyList[6],
            child: Column(
              children: [
                Visibility(
                  visible: (radioButtonValuesList['driveline_type'] ==
                          'series_hybrid' ||
                      radioButtonValuesList['driveline_type'] ==
                          'parallel_hybrid'),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5, top: 10),
                        child:
                            Text('Do you know how to read power consumption?'),
                      ),
                      FormField(
                        builder: (FormFieldState<bool> state) {
                          return Column(
                            children: [
                              state.hasError
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        state.errorText!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("Modbus TCP"),
                                leading: Radio(
                                  value: 'modbus_tcp',
                                  groupValue: radioButtonValuesList[
                                      'know_how_to_read_power_consumption'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'know_how_to_read_power_consumption'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("Modbuc RT"),
                                leading: Radio(
                                  value: 'modbuc_rt',
                                  groupValue: radioButtonValuesList[
                                      'know_how_to_read_power_consumption'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'know_how_to_read_power_consumption'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA0183"),
                                leading: Radio(
                                  value: 'nmea0183',
                                  groupValue: radioButtonValuesList[
                                      'know_how_to_read_power_consumption'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'know_how_to_read_power_consumption'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                horizontalTitleGap: 0,
                                visualDensity: VisualDensity(vertical: -4),
                                title: Text("NMEA2000"),
                                leading: Radio(
                                  value: 'nmea2000',
                                  groupValue: radioButtonValuesList[
                                      'know_how_to_read_power_consumption'],
                                  onChanged: (value) {
                                    setState(() {
                                      state.setValue(true);
                                      if (value != null) {
                                        radioButtonValuesList[
                                                'know_how_to_read_power_consumption'] =
                                            value.toString();
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (value != true) {
                            return 'Required!';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text('Is there anything else you want to connect?'),
                ),
                FormField(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      children: [
                        state.hasError
                            ? SizedBox(
                                width: double.infinity,
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              )
                            : Container(),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("Yes"),
                          leading: Radio(
                            value: 'yes',
                            groupValue: radioButtonValuesList[
                                'anything_else_you_want_to_contact'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList[
                                          'anything_else_you_want_to_contact'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          horizontalTitleGap: 0,
                          visualDensity: VisualDensity(vertical: -4),
                          title: Text("No"),
                          leading: Radio(
                            value: 'no',
                            groupValue: radioButtonValuesList[
                                'anything_else_you_want_to_contact'],
                            onChanged: (value) {
                              setState(() {
                                state.setValue(true);
                                if (value != null) {
                                  radioButtonValuesList[
                                          'anything_else_you_want_to_contact'] =
                                      value.toString();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (value != true) {
                      return 'Required!';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: radioButtonValuesList[
                          'anything_else_you_want_to_contact'] ==
                      'yes',
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5, top: 10),
                        child: Text(
                            'Please write down a description and connection protocols below:'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller:
                            _createTextController('final_extra_description'),
                        maxLength: 150,
                        maxLines: 10,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(),
                          labelText: 'Connections and protocols...',
                          labelStyle: TextStyle(),
                          errorStyle: TextStyle(height: 0.5),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        validator: MultiValidator(
                          [
                            RequiredValidator(errorText: "Text can't be empty!")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 4,
          title: Text('Confirm'),
          content: Column(
            children: [
              Text(
                'All questions completed!\n\nYou can always delete or edit your vessel in the future if needed.',
              ),
              Visibility(
                visible: _showDuplicateVesselError,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'A vessel already exists with the same name!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ];

  Widget _drivelineExtraInputsBuilder(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _createTextController('driveline_${index + 1}'),
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

  TextEditingController _createTextController(String textIdentifier) {
    // Incase if user refreshes the form,
    // Assign previous controller to the new texfield
    if (textControllerList.containsKey(textIdentifier)) {
      late final TextEditingController existingController;
      textControllerList.forEach((key, value) {
        if (key == textIdentifier) {
          existingController = value;
          return;
        }
      });
      return existingController;
    }
    final newController = TextEditingController();
    final controllerObject = {textIdentifier: newController};
    textControllerList.addEntries(controllerObject.entries);

    return newController;
  }

  Future pickImage(ImageSource imageSource, int storeInVariable) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final choosenImage = XFile(image.path);
      setState(() {
        switch (storeInVariable) {
          case 0:
            showImage1Error = false;
            imageData1 = choosenImage;
            break;
          case 1:
            showImage2Error = false;
            imageData2 = choosenImage;
            break;
          case 2:
            showImage3Error = false;
            imageData3 = choosenImage;
            break;

          default:
            break;
        }
      });
    } on PlatformException catch (error) {
      print('Failed to pick image: $error');
    }
  }
}
