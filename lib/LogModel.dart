class LoggerModel {
  LoggerModel({
    this.entityId,
    this.eventName,
    this.eventTs,
    this.status,
    this.value,
  });

  String entityId;
  String eventName;
  int eventTs;
  int status;
  dynamic value;

  factory LoggerModel.fromJson(Map<String, dynamic> json) => LoggerModel(
        entityId: json["entity_id"] == null ? null : json["entity_id"],
        eventName: json["event_name"] == null ? null : json["event_name"],
        eventTs: json["event_ts"] == null ? null : json["event_ts"],
        value: json["value"] == null ? null : json["value"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "entity_id": entityId == null ? null : entityId,
        "event_name": eventName == null ? null : eventName,
        "event_ts": eventTs == null ? null : eventTs,
        "status": status == null ? null : status,
        "value": value == null ? null : value,
      };
}
