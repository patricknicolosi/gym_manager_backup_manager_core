import 'package:gym_manager_backup_manager_core/core.dart';
import 'package:gym_manager_core/core.dart';

void main() async {
  print(
    await BackupRepository.schedule(
      BackupShift(dayOfWeek: 1, start: TimeOfDay(hour: 12, minute: 20)),
    ),
  );

  print(await BackupRepository.list());
  print(await BackupRepository.backup());
}
