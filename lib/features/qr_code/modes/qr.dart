import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr.freezed.dart';

@freezed
class Qr with _$Qr {
  const factory Qr({
    required String data,
    required DateTime due,
  }) = _Qr;
}
