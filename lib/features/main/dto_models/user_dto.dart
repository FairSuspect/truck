import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@Freezed(toJson: false, fromJson: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class UserDto with _$UserDto {
  const factory UserDto({
    String? companyEmail,
    required String truckNumber,
    required String vin,
    required String driverPassword,
    required String driverName,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}


// {
//   "company_email": "2",
//   "truck_number": "sfasf",
//   "truck_registration_file": null,
//   "vin": "2222",
//   "license_expiration": null,
//   "year": null,
//   "truck_inspection_file": null,
//   "truck_inspection_expiration": null,
//   "phycisal_damage_file": null,
//   "physical_damage_expiration": null,
//   "NY": null,
//   "NY_file": null,
//   "KY": null,
//   "KY_file": null,
//   "NM": null,
//   "NM_file": null,
//   "OR": null,
//   "OR_file": null,
//   "leaser_and_borrower_file": null,
//   "driver_and_company_file": null,
//   "random_drug_test_exparation": null,
//   "random_drug_test_exparation_file": null,
//   "driver_password": "2",
//   "driver_name": "2"
// }