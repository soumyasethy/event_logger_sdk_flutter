import 'package:logger_sdk/LogModel.dart';
import 'package:logger_sdk/db/db.dart';
import 'package:uuid/uuid.dart';

class EventLogger with DBHelper {
  void pushEvent(eventName, {dynamic value}) {
    if (value != null) {
      value = value.toString();
    }
    LoggerModel loggerModel = LoggerModel();
    loggerModel.eventTs = (DateTime.now()).millisecondsSinceEpoch;
    loggerModel.entityId = Uuid().v4();
    loggerModel.eventName = eventName;
    loggerModel.value = value;
    loggerModel.status = Status.pending;

    super.insertEvent(loggerModel);
  }

  Future<List<LoggerModel>> getPendingEvents() async {
    return await super.getPendingEvents();
  }

  Future<void> deleteLoggerModel(String entityId) async {
    await super.deleteLoggerModel(entityId);
  }
}
