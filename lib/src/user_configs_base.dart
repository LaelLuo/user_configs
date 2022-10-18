import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class UserConfigs {
  final String _configName;

  late String _userHome;

  late File _configFile;

  late Map<String, dynamic> _data;

  UserConfigs(this._configName);

  Future<void> init() async {
    if (Platform.isWindows) {
      _userHome = Platform.environment['USERPROFILE']!;
    } else if (Platform.isLinux || Platform.isMacOS) {
      _userHome = Platform.environment['HOME']!;
    } else {
      final directory = await path_provider.getApplicationDocumentsDirectory();
      _userHome = directory.path;
    }
    _configFile = File(path.join(_userHome, '.config', _configName, 'config.json'));
    if (_configFile.existsSync()) {
      _data = jsonDecode(await _configFile.readAsString());
    } else {
      await _configFile.create(recursive: true);
      _data = {};
    }
  }

  dynamic get(String key) => _data[key];

  String getString(String key) => _data[key].toString();

  int getInt(String key) => int.parse(getString(key));

  double getDouble(String key) => double.parse(getString(key));

  bool getBoolean(String key) => getString(key) == 'true';

  void set(String key, dynamic value) {
    _data[key] = value;
    _configFile.writeAsString(jsonEncode(_data));
  }
}
