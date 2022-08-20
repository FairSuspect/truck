import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(toJson: false, fromJson: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class User with _$User {
  const factory User({
    required String vin,
    required String driverName,
    required String truckNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
