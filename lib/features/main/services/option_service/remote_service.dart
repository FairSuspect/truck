import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/services/option_service/option_service.dart';
import 'package:truck/features/shared/view/snackbars.dart';
import 'package:truck/services/navigation.dart';
import 'package:truck/services/remote/api.dart';

class RemoteOptionService implements OptionService {
  @override
  Future<Map<String, List<Option>>> getAll() async {
    final response = await Api().dio.get(
          '/driver/get_current_truck/',
        );
    final data = response.data;
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
  Future<String> getFile(String query, String path) async {
    final filePath = "$path/$query";
    final logger = Logger("Downloader");
    logger.log(Level.INFO, "Craeting file $filePath");
    try {
      final response = await Api().dio.download(
        '/driver/get_truck_file/',
        filePath,
        queryParameters: {
          'filename': query,
        },
      );
      logger.log(Level.INFO, "Headers: ${response.headers}");
      final dest = response.headers.map['content-disposition'];
      final content = dest?.first ?? '';
      String fileName =
          content.substring(content.indexOf('"') + 1, content.lastIndexOf('"'));
      fileName = fileName.split('/').last;
      final newFilePath = "$path/$fileName";
      logger.log(Level.INFO, "file path from dio: $newFilePath");
      await File(newFilePath).create();
      await File(filePath).copy(newFilePath);
      await File(filePath).delete();
      return newFilePath;
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        Navigation()
            .scaffoldKey
            .currentState!
            .showSnackBar(SnackBars.info("File not found"));
        return '';
      }
      Navigation()
          .scaffoldKey
          .currentState!
          .showSnackBar(SnackBars.info("Unknown server error"));
      return '';
    }
  }
}
