import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/services/option_service/abscract.dart';
import 'package:truck/features/shared/view/snackbars.dart';
import 'package:truck/services/navigation.dart';

class OptionProvider extends ChangeNotifier {
  final OptionService service;

  OptionProvider(this.service) {
    fetchOptions();
    initState();
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
  List<Option> get filteredOptions => options[filter] ?? [];
  final ReceivePort _port = ReceivePort();

  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    FlutterDownloader.registerCallback(downloadCallback);

    _port.listen((dynamic data) {
      final String id = data[0];
      final DownloadTaskStatus status = data[1];
      final int progress = data[2];
      final logger = Logger("Downloader");
      logger.log(Level.INFO, "Download updated");
      if (status == DownloadTaskStatus.enqueued) {
        Navigation()
            .scaffoldKey
            .currentState!
            .showSnackBar(SnackBars.info("Download started..."));
      }
      if (status == DownloadTaskStatus.failed) {
        Navigation()
            .scaffoldKey
            .currentState!
            .showSnackBar(SnackBars.info("Download failed!"));
      }
      if (status == DownloadTaskStatus.complete) {
        Navigation().scaffoldKey.currentState!.showSnackBar(SnackBars.info(
            "Download completed! \n You can open it via notification"));
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');

    send!.send([id, status, progress]);
  }

  Future<void> onOptionTap(String key) async {
    final link = await service.getFile(key);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("authToken");

    final path = await _getPath();
    Navigation().scaffoldKey.currentState!.showSnackBar(SnackBars.info(
        "Download started. You can check status and open file via notification"));
    final taskId = await FlutterDownloader.enqueue(
      url: link,
      headers: {'Cookie': token ?? ''},
      savedDir: path,
      saveInPublicStorage: true,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
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
