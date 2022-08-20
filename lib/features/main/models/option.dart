import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';

@freezed
class Option with _$Option {
  const factory Option({
    required String name,
    required DateTime? deadline,
    required DateTime? dateCreated,
    required String key,
  }) = _Option;
}
