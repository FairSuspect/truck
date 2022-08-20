import 'dart:math';

import 'package:truck/features/main/models/option.dart';

import 'abscract.dart';

class StubOptionService implements OptionService {
  @override
  Future<Map<String, List<Option>>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    if (Random().nextBool()) {
      throw Exception();
    }
    const data = {
      "company_email": "string",
      "truck_number": "string",
      "truck_registration_file": "2022-08-20T12:58:19.322Z",
      "vin": "string",
      "license_expiration": "2022-08-20T12:58:19.322Z",
      "year": "string",
      "truck_inspection_file": "2022-08-20T12:58:19.322Z",
      "truck_inspection_expiration": "2022-08-20T12:58:19.322Z",
      "phycisal_damage_file": "2022-08-20T12:58:19.322Z",
      "physical_damage_expiration": "2022-08-20T12:58:19.322Z",
      "NY_file": "2022-07-20T12:58:19.322Z",
      "NY": "2022-08-29T12:58:19.322Z",
      "KY_file": "2022-08-14T12:58:19.322Z",
      "KY": "2022-08-19T12:58:19.322Z",
      "NM_file": "2022-02-20T12:58:19.322Z",
      "NM": "2022-12-20T12:58:19.322Z",
      "OR": "2022-08-20T12:58:19.322Z",
      "OR_file": "2022-08-20T12:58:19.322Z",
      "leaser_and_borrower_file": "2022-08-20T12:58:19.322Z",
      "driver_and_company_file": "2022-08-20T12:58:19.322Z",
      "random_drug_test_exparation": "2022-08-20T12:58:19.322Z",
      "random_drug_test_exparation_file": "2022-08-20T12:58:19.322Z",
      "driver_password": "string",
      "driver_name": "string"
    };
    final DateTime? truckRegistration =
        DateTime.tryParse(data['truck_registration_file'] ?? '');
    final DateTime? truckRegistrationExpiration =
        DateTime.tryParse(data['license_expiration'] ?? '');
    final DateTime? truckInspection =
        DateTime.tryParse(data['truck_inspection_file'] ?? '');
    final DateTime? truckInspectionExpiration =
        DateTime.tryParse(data['truck_inspection_expiration'] ?? '');
    final DateTime? physicalDamage =
        DateTime.tryParse(data['phycisal_damage_file'] ?? '');
    final DateTime? physicalDamageExpiration =
        DateTime.tryParse(data['physical_damage_expiration'] ?? '');
    final DateTime? ny = DateTime.tryParse(data['NY_file'] ?? '');
    final DateTime? nyExpiration = DateTime.tryParse(data['NY'] ?? '');
    final DateTime? ky = DateTime.tryParse(data['KY_file'] ?? '');
    final DateTime? kyExpiration = DateTime.tryParse(data['KY'] ?? '');
    final DateTime? nm = DateTime.tryParse(data['NM_file'] ?? '');
    final DateTime? nmExpiration = DateTime.tryParse(data['NM'] ?? '');
    final DateTime? or = DateTime.tryParse(data['OR_file'] ?? '');
    final DateTime? orExpiration = DateTime.tryParse(data['OR'] ?? '');
    final DateTime? drugTest =
        DateTime.tryParse(data['random_drug_test_exparation_file'] ?? '');
    final DateTime? drugTestExpiration =
        DateTime.tryParse(data['random_drug_test_exparation'] ?? '');

    final Map<String, List<Option>> options = {
      "Truck Registration": [
        Option(
            name: "Registration",
            deadline: truckRegistrationExpiration,
            dateCreated: truckRegistration,
            key: 'truck_registration_file'),
        Option(
            name: "Truck Inspection",
            deadline: truckInspectionExpiration,
            dateCreated: truckInspection,
            key: "truck_inspection_file"),
      ],
      "Permits": [
        Option(
            name: "NY",
            deadline: nyExpiration,
            dateCreated: ny,
            key: 'NY_file'),
        Option(
            name: "KY",
            deadline: kyExpiration,
            dateCreated: ky,
            key: 'KY_file'),
        Option(
            name: "OR",
            deadline: orExpiration,
            dateCreated: or,
            key: "OR_file"),
        Option(
            name: "NM",
            deadline: nmExpiration,
            dateCreated: nm,
            key: "NM_file"),
        // Option(
        //     name: name, deadline: deadline, dateCreated: dateCreated, key: key),
      ],
      "Insuranse": [
        Option(
            name: "Physical Damage",
            deadline: physicalDamageExpiration,
            dateCreated: physicalDamage,
            key: 'phycisal_damage_file'),
      ],
      "Agreements": [
        const Option(
            name: "Leaser and Borrower",
            deadline: null,
            dateCreated: null,
            key: 'leaser_and_borrower_file'),
        const Option(
            name: "Driver and company",
            deadline: null,
            dateCreated: null,
            key: 'driver_and_company'),
      ],
      "Drug Test": [
        Option(
            name: "Drug Test",
            deadline: drugTestExpiration,
            dateCreated: drugTest,
            key: 'random_drug_test_exparation_file'),
      ],
    };
    return options;
  }

  @override
  Future<String> getFile(String query, String dummy) {
    throw UnimplementedError();
  }
}
