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
    } catch (e) {
      isLoading = false;
      hasError = true;
    }

    notifyListeners();
  }

  List<Option> _options = [];

  List<Option> get options => _options;

  set options(List<Option> options) {
    _options = options;
    isLoading = false;
    hasError = false;
  }
}
