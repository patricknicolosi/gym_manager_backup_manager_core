import 'package:dio/dio.dart';
import 'package:gym_manager_backup_manager_core/models/backup_shift.dart';
import 'package:gym_manager_backup_manager_core/services/backup_api_service.dart';

class BackupRepository {
  static Future<List<BackupShift>> list() async {
    String url =
        'https://${BackupApiService.getInstance().getIP()}:${BackupApiService.getInstance().getPORT()}/backup';
    Response response = await BackupApiService.getInstance().dio.get(url);
    if (response.data["responseType"] == "ok") {
      List<BackupShift> backupShifts =
          (response.data["body"] as List<dynamic>)
              .map((e) => BackupShift.fromJson(e))
              .toList();
      return backupShifts;
    } else {
      throw response.data;
    }
  }

  static Future<BackupShift> schedule(BackupShift backupShift) async {
    String url =
        'https://${BackupApiService.getInstance().getIP()}:${BackupApiService.getInstance().getPORT()}/backup/schedule';
    Map<String, dynamic> backupShiftMapped = backupShift.toJson();
    Response response = await BackupApiService.getInstance().dio.post(
      url,
      data: backupShiftMapped,
    );
    if (response.data["responseType"] == "ok") {
      return backupShift;
    } else {
      throw response.data;
    }
  }

  static Future backup() async {
    String url =
        'https://${BackupApiService.getInstance().getIP()}:${BackupApiService.getInstance().getPORT()}/backup';
    Response response = await BackupApiService.getInstance().dio.post(url);
    if (response.data["responseType"] != "ok") {
      throw response.data;
    }
  }

  static Future<bool> delete(String shiftId) async {
    String url =
        'https://${BackupApiService.getInstance().getIP()}:${BackupApiService.getInstance().getPORT()}/backup/$shiftId';
    Response response = await BackupApiService.getInstance().dio.delete(url);
    if (response.data["responseType"] == "ok") {
      return true;
    } else {
      throw response.data;
    }
  }

  static Future<BackupShift> update(BackupShift backupShift) async {
    if (backupShift.id.isEmpty) {
      throw Exception("Cannot update backup shift without ID");
    }

    String url =
        'https://${BackupApiService.getInstance().getIP()}:${BackupApiService.getInstance().getPORT()}/backup/${backupShift.id}';
    Map<String, dynamic> backupShiftMapped = backupShift.toJson();
    Response response = await BackupApiService.getInstance().dio.put(
      url,
      data: backupShiftMapped,
    );
    if (response.data["responseType"] == "ok") {
      return backupShift;
    } else {
      throw response.data;
    }
  }

  static Future<BackupShift> getById(String shiftId) async {
    List<BackupShift> shifts = await list();
    try {
      return shifts.firstWhere((shift) => shift.id == shiftId);
    } catch (e) {
      throw Exception("Backup shift with ID $shiftId not found");
    }
  }

  static Future<bool> exists(String shiftId) async {
    try {
      await getById(shiftId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
