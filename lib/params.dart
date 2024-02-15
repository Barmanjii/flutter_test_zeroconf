import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart' as yaml;

class Robot {
  late String machineId;

  Future<void> getMachineId() async {
    var machineInfoPath =
        path.join(Platform.environment['HOME']!, '.machineinfo.yaml');
    try {
      var file = File(machineInfoPath);
      if (await file.exists()) {
        var data = yaml.loadYaml(await file.readAsString());
        machineId = data['MACHINEID'] ?? 'Unknown';
      } else {
        print('The file $machineInfoPath does not exist.');
      }
    } catch (e) {
      print('Exception while reading the file - $e');
    }
  }
}
