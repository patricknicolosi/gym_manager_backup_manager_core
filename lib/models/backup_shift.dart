import 'package:gym_manager_core/core.dart';
import 'package:uuid/uuid.dart';

class BackupShift {
  String id;
  int dayOfWeek;
  TimeOfDay start;

  BackupShift({String? id, required this.dayOfWeek, required this.start})
    : id = id ?? const Uuid().v4();

  factory BackupShift.fromJson(Map<String, dynamic> json) {
    return BackupShift(
      id: json['id'] as String,
      dayOfWeek: json['dayOfWeek'] as int,
      start: TimeOfDay.fromString(json['start']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'dayOfWeek': dayOfWeek, 'start': start.format24Hour()};
  }

  String toCronExpression() {
    final minutes = start.minute;
    final hours = start.hour;
    final dow = dayOfWeek;
    return '$minutes $hours * * $dow';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackupShift &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return toJson().toString();
  }
}
