import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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

  Map<String, double?> progresses = {};

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
  List<Option> get filteredOptions =>
      options[filter]?.where((element) => element.deadline != null).toList() ??
      [];

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> onOptionTap(String key) async {
    final path = await _getPath();
    final filePath = await service.getFile(key, path);
    final result = await OpenFile.open(filePath);
    Logger("OpenFile").log(Level.INFO, "${result.type}: ${result.message}");
  }

  Future<String> _getPath() async {
    late Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    return dir!.path;
  }
}
