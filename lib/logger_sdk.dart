library logger_sdk;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger_sdk/LogModel.dart';
import 'package:logger_sdk/event_logger.dart';
import 'package:workmanager/workmanager.dart';

EventLogger eventLogger = EventLogger();

void sendAnalyticsEvent(String eventName, {dynamic value}) {
  eventLogger.pushEvent(eventName, value: value);
}

void runJob() async {
  List<LoggerModel> data = await eventLogger.getPendingEvents();
  var response = await postEvent(data);
  if (response.statusCode == 200) {
    data.forEach((event) {
      eventLogger.deleteLoggerModel(event.entityId);
    });
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    runJob();
    return Future.value(true);
  });
}

void initEventLogger() {
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  // Periodic task registration
  Workmanager.registerPeriodicTask(
    "2",
    "syncWithServer",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    frequency: Duration(minutes: 15),
  );
}

Future<http.Response> postEvent(List<dynamic> body) {
  return http.post(
    'http://chimay_stag.bounce.bike/bulk_publish_records',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AppToken': 'ykD0aGLjXRecH521aqJk',
      'authkey': 'ykD0aGLjXRecH521aqJk',
      'token': 'f3523c66-8782-11e8-8973-c329568ede24',
    },
    body: jsonEncode(body),
  );
}
