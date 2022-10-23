import 'dart:io';

import 'package:image_picker/image_picker.dart';

class VesselModel {
  final String company_name;
  final String vessel_name;
  final String imo_number;
  final String tech_full_name;
  final String tech_email;
  final String planning_full_name;
  final String planning_email;
  final String number_of_drivelines;
  final List<dynamic> driveline_info_list;
  final String driveline_type;
  final String display_size;

  final String? fuel_flow_signal;
  final String? fuel_flow_signal_type;
  final String? location_of_wires;
  final String? fuel_flow_installed;
  final String? engine_speed_and_torque_signals;
  final String tank_sensor;

  // If user chooses to install an extra system
  final String install_power_generator_to_system;
  final String? extra_fuel_flow_signal;
  final String? extra_fuel_flow_signal_type;
  final String? extra_location_of_wires;
  final String? extra_fuel_flow_installed;
  final String? extra_engine_speed_and_torque_signals;

  final String gps_installed;
  final String? gps_type;

  final String compass_installed;
  final String? compass_type;
  final String? user_extra_connection_description;

  final XFile image1;
  final XFile image2;
  final XFile image3;

  VesselModel(
    this.company_name,
    this.vessel_name,
    this.imo_number,
    this.tech_full_name,
    this.tech_email,
    this.planning_full_name,
    this.planning_email,
    this.number_of_drivelines,
    this.driveline_info_list,
    this.driveline_type,
    this.image1,
    this.image2,
    this.image3,
    this.tank_sensor,
    this.fuel_flow_signal,
    this.fuel_flow_signal_type,
    this.location_of_wires,
    this.fuel_flow_installed,
    this.engine_speed_and_torque_signals,
    this.install_power_generator_to_system,
    this.extra_fuel_flow_signal,
    this.extra_fuel_flow_signal_type,
    this.extra_location_of_wires,
    this.extra_fuel_flow_installed,
    this.extra_engine_speed_and_torque_signals,
    this.gps_installed,
    this.gps_type,
    this.compass_installed,
    this.compass_type,
    this.user_extra_connection_description,
    this.display_size,
  );

  Map<String, dynamic> get createParsedList {
    final unParsedList = {
      'Company name': company_name,
      'Vessel name': vessel_name,
      'Imo number': imo_number,
      'Tech name': tech_full_name,
      'Tech email': tech_email,
      'Planning name': planning_full_name,
      'Planning email': planning_email,
      'Number of drivelines': number_of_drivelines,
      'Driveline info list': driveline_info_list,
      'Driveline type': driveline_type,
      'Tank sensor': tank_sensor,
      'Fuel flow signal': fuel_flow_signal,
      'Fuel flow signal type': fuel_flow_signal_type,
      'Location of wires': location_of_wires,
      'Fuel flow installed': fuel_flow_installed,
      'Engine speed and torque signals': engine_speed_and_torque_signals,
      'Install power generator to system': install_power_generator_to_system,
      'Extra fuel flow signal': extra_fuel_flow_signal,
      'Extra fuel flow signal type': extra_fuel_flow_signal_type,
      'Extra location of wires': extra_location_of_wires,
      'Extra fuel flow installed': extra_fuel_flow_installed,
      'Extra speed and torque signals': extra_engine_speed_and_torque_signals,
      'GPS installed': gps_installed,
      'GPS type': gps_type,
      'Compass installed': compass_installed,
      'Compass type': compass_type,
      'Additional user connections': user_extra_connection_description,
      'Preferred display size': display_size,
    };

    Map<String, dynamic> parsedList = {};

    unParsedList.forEach((key, value) {
      if (value != null) {
        parsedList.addEntries({key: value}.entries);
      }
    });

    return parsedList;
  }
}
