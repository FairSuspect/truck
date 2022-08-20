import 'package:truck/features/main/models/option.dart';

abstract class OptionService {
  /// Возвращает весь список Option
  Future<Map<String, List<Option>>> getAll();

  Future<String> getFile(String query);
}
