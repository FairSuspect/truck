import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/services/option_service/option_service.dart';
import 'package:truck/services/remote/api.dart';

class RemoteOptionService implements OptionService {
  static const _names = [
    'truck_registration_file',
    'truck_inspection_file',
    'physical_damage_file',
    "NY_file",
    "KY_file",
    "NM_file",
    "OR_file",
    'leaser_and_borrower_file',
    'driver_and_company_file',
    'random_drug_test_expiration_file',
  ];

  @override
  Future<List<Option>> getAll() async {
    final response = await Api().dio.get(
          '/driver/get_current_truck/',
        );
    final data = response.data;
    final DateTime? truckRegistration =
        DateTime.tryParse(data['truck_registration_file'] ?? '');
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

    final List<Option> options = [
      Option(
          name: "Truck Registration",
          deadline: null,
          dateCreated: truckRegistration,
          key: 'truck_registration_file'),
      Option(
          name: "Truck Inspection",
          deadline: truckInspectionExpiration,
          dateCreated: truckInspection,
          key: "truck_inspection_file"),
      Option(
          name: "Physical Damage",
          deadline: physicalDamageExpiration,
          dateCreated: physicalDamage,
          key: 'phycisal_damage_file'),
      Option(name: "NY", deadline: nyExpiration, dateCreated: ny, key: 'NY'),
      Option(name: "KY", deadline: kyExpiration, dateCreated: ky, key: 'KY'),
      Option(name: "NM", deadline: nmExpiration, dateCreated: nm, key: "NM"),
      Option(name: "OR", deadline: orExpiration, dateCreated: or, key: "OR"),
      Option(
          name: "Random Drug Test",
          deadline: drugTestExpiration,
          dateCreated: drugTest,
          key: 'random_drug_test_exparation_file'),
      // Option(
      //     name: name, deadline: deadline, dateCreated: dateCreated, key: key),
    ];
    return options;
  }

  @override
  Future<String> getFile(String query) async {
    final response = await Api().dio.get(
      '/driver/get_truck_file/',
      queryParameters: {
        'filename': query,
      },
    );
    return response.data;
  }
}
