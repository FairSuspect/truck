import 'package:freezed_annotation/freezed_annotation.dart';

part 'credentials.freezed.dart';

@freezed
class Credentials with _$Credentials {
  const factory Credentials({required int driverId, required int truckId}) =
      _Credentials;
}
