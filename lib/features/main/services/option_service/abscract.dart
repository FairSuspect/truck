import 'package:truck/features/main/models/option.dart';

abstract class OptionService {
  /// Возвращает весь список Option
  Future<List<Option>> getAll();
}
