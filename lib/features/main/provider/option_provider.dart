import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/services/option_service/abscract.dart';
import 'package:truck/features/main/view/option_tile.dart';
import 'package:truck/features/shared/view/snackbars.dart';
import 'package:truck/services/navigation.dart';
import 'package:truck/services/theme/light_theme.dart';

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

  Color? filterNotificationColor(String filter, TimeIndicatorColors colors) {
    final progresses = options[filter]!.map((e) => e.progress).toList();
    final leastProgress = progresses.reduce(min);

    final color = colorByProgress(colors, leastProgress);
    return color == colors.moreThanMonth ? null : color;
  }

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
    if (result.type == ResultType.error) {
      Navigation()
          .scaffoldKey
          .currentState
          ?.showSnackBar(SnackBars.info("Unkonwn error while openning file"));
    } else if (result.type == ResultType.noAppToOpen) {
      Navigation().scaffoldKey.currentState?.showSnackBar(
          SnackBars.info("No application found to open this file"));
    } else if (result.type == ResultType.fileNotFound) {
      Navigation().scaffoldKey.currentState?.showSnackBar(SnackBars.info(
          "File is lost. make sure that this file has extension"));
    }
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

extension OverdueOption on Option {
  bool get hasOverdue =>
      deadline != null ? DateTime.now().isAfter(deadline!) : false;
  static const aLotOfDays = 30;
  double get progress {
    if (hasOverdue) return 0;
    if (deadline == null) return double.infinity;
    var inDays = deadline!.difference(DateTime.now()).inDays;
    return inDays > aLotOfDays ? 1 : inDays / 30;
  }
}
