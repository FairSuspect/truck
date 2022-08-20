import 'package:flutter/widgets.dart';
import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/services/option_service/abscract.dart';

class OptionProvider extends ChangeNotifier {
  final OptionService service;

  OptionProvider(this.service) {
    fetchOptions();
  }

  bool isLoading = false;
  bool hasError = false;

  Future<void> fetchOptions() async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    try {
      options = await service.getAll();
      filter = options.keys.first;
    } catch (e) {
      isLoading = false;
      hasError = true;
    }

    notifyListeners();
  }

  String filter = '';
  Map<String, List<Option>> _options = {};

  Map<String, List<Option>> get options => _options;

  set options(Map<String, List<Option>> options) {
    _options = options;
    isLoading = false;
    hasError = false;
  }

  void onFilterSelected(String value) {
    filter = value;
    notifyListeners();
  }

  List<String> get filters => options.keys.toList();
  List<Option> get filteredOptions => options[filter] ?? [];

  void onOptionTap(String key) {}
}
