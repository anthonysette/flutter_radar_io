import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

class EventsReceived {
  EventsReceived(
    this.events,
    this.user,
  );
  List<RadarEvent> events;
  RadarUser user;
}

class LocationUpdated {
  LocationUpdated(
    this.location,
    this.user,
  );
  Location location;
  RadarUser user;
}

class ClientLocationUpdated {
  ClientLocationUpdated(
    this.location,
    this.stopped,
    this.source,
  );
  Location location;
  bool stopped;
  RadarLocationSource source;
}

@JsonSerializable()
class RadarUser {
  RadarUser(
    this.id,
    this.userId,
    this.deviceId,
    this.description,
    this.metadata,
    this.location,
    this.geofences,
    this.place,
    this.stopped,
    this.foreground,
    this.country,
    this.state,
    this.dma,
    this.postalCode,
    this.nearbyPlaceChains,
    this.segments,
    this.topChains,
    this.source,
    this.proxy,
  );

  String id;
  String userId;
  String deviceId;
  String description;
  Map<String, dynamic> metadata;
  Location location;
  List<RadarGeofence> geofences;
  RadarPlace place;
  bool stopped;
  bool foreground;
  RadarRegion country;
  RadarRegion state;
  RadarRegion dma;
  RadarRegion postalCode;
  List<RadarChain> nearbyPlaceChains;
  List<RadarSegment> segments;
  List<RadarChain> topChains;
  RadarLocationSource source;
  bool proxy;

  factory RadarUser.fromJson(Map<String, dynamic> json) =>
      _$RadarUserFromJson(json);
  Map<String, dynamic> toJson() => _$RadarUserToJson(this);
}

@JsonSerializable()
class RadarEvent {
  RadarEvent(
    this.id,
    this.createdAt,
    this.actualCreatedAt,
    this.live,
    this.type,
    this.geofence,
    this.place,
    this.region,
    this.alternatePlaces,
    this.verifiedPlace,
    this.verification,
    this.confidence,
    this.location,
  );

  String id;
  double createdAt;
  double actualCreatedAt;
  bool live;
  RadarEventType type;
  RadarGeofence geofence;
  RadarPlace place;
  RadarRegion region;
  List<RadarPlace> alternatePlaces;
  RadarPlace verifiedPlace;
  RadarEventVerification verification;
  RadarEventConfidence confidence;
  Location location;

  factory RadarEvent.fromJson(Map<String, dynamic> json) =>
      _$RadarEventFromJson(json);
  Map<String, dynamic> toJson() => _$RadarEventToJson(this);
}

@JsonSerializable()
class RadarSegment {
  RadarSegment(
    this.description,
    this.externalId,
  );

  String description;
  String externalId;

  factory RadarSegment.fromJson(Map<String, dynamic> json) =>
      _$RadarSegmentFromJson(json);
  Map<String, dynamic> toJson() => _$RadarSegmentToJson(this);
}

@JsonSerializable()
class Location {
  Location(
    this.latitude,
    this.longitude,
    this.speed,
    this.accuracy,
    this.altitude,
    this.time,
  );

  double latitude;
  double longitude;
  double speed;
  double accuracy;
  double altitude;
  double time;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class RadarRegion {
  RadarRegion(
    this.id,
    this.name,
    this.code,
    this.type,
    this.flag,
  );

  String id;
  String name;
  String code;
  String type;
  String flag;

  factory RadarRegion.fromJson(Map<String, dynamic> json) =>
      _$RadarRegionFromJson(json);
  Map<String, dynamic> toJson() => _$RadarRegionToJson(this);
}

@JsonSerializable()
class RadarPlace {
  RadarPlace(
    this.id,
    this.name,
    this.categories,
    this.chain,
    this.location,
    this.group,
    this.metadata,
  );

  String id;
  String name;
  List<String> categories;
  RadarChain chain;
  RadarCoordinate location;
  String group;
  Map<String, dynamic> metadata;

  factory RadarPlace.fromJson(Map<String, dynamic> json) =>
      _$RadarPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$RadarPlaceToJson(this);
}

@JsonSerializable()
class RadarChain {
  RadarChain(
    this.slug,
    this.name,
    this.ecternalId,
    this.metadata,
  );

  String slug;
  String name;
  String ecternalId;
  Map<String, dynamic> metadata;

  factory RadarChain.fromJson(Map<String, dynamic> json) =>
      _$RadarChainFromJson(json);
  Map<String, dynamic> toJson() => _$RadarChainToJson(this);
}

@JsonSerializable()
class RadarGeofence {
  RadarGeofence(
    this.id,
    this.description,
    this.tag,
    this.externalId,
    this.metadata,
    this.geometry,
  );

  String id;
  String description;
  String tag;
  String externalId;
  Map<String, dynamic> metadata;
  RadarGeofenceGeometry geometry;

  factory RadarGeofence.fromJson(Map<String, dynamic> json) =>
      _$RadarGeofenceFromJson(json);
  Map<String, dynamic> toJson() => _$RadarGeofenceToJson(this);
}

class RadarGeofenceGeometry {}

@JsonSerializable()
class RadarCircleGeometry extends RadarGeofenceGeometry {
  RadarCircleGeometry(
    this.center,
    this.radius,
  );

  RadarCoordinate center;
  double radius;

  factory RadarCircleGeometry.fromJson(Map<String, dynamic> json) =>
      _$RadarCircleGeometryFromJson(json);
  Map<String, dynamic> toJson() => _$RadarCircleGeometryToJson(this);
}

@JsonSerializable()
class RadarPolygonGeometry extends RadarGeofenceGeometry {
  RadarPolygonGeometry(
    this.coordinates,
  );

  List<RadarCoordinate> coordinates;

  factory RadarPolygonGeometry.fromJson(Map<String, dynamic> json) =>
      _$RadarPolygonGeometryFromJson(json);
  Map<String, dynamic> toJson() => _$RadarPolygonGeometryToJson(this);
}

@JsonSerializable()
class RadarCoordinate {
  RadarCoordinate(
    this.latitude,
    this.longitude,
  );

  double latitude;
  double longitude;

  factory RadarCoordinate.fromJson(Map<String, dynamic> json) =>
      _$RadarCoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$RadarCoordinateToJson(this);
}

enum RadarEventType {
  UNKNOWN,
  USER_ENTERED_GEOFENCE,
  USER_ENTERED_HOME,
  USER_ENTERED_OFFICE,
  USER_ENTERED_PLACE,
  USER_ENTERED_REGION_COUNTRY,
  USER_ENTERED_REGION_DMA,
  USER_ENTERED_REGION_STATE,
  USER_EXITED_GEOFENCE,
  USER_EXITED_HOME,
  USER_EXITED_OFFICE,
  USER_EXITED_PLACE,
  USER_EXITED_REGION_COUNTRY,
  USER_EXITED_REGION_DMA,
  USER_EXITED_REGION_STATE,
  USER_NEARBY_PLACE_CHAIN,
  USER_STARTED_COMMUTING,
  USER_STARTED_TRAVELING,
  USER_STOPPED_COMMUTING,
  USER_STOPPED_TRAVELING,
}

enum RadarEventConfidence {
  HIGH,
  LOW,
  MEDIUM,
  NONE,
}

enum RadarEventVerification {
  ACCEPT,
  REJECT,
  UNVERIFY,
}

enum RadarLocationSource {
  BACKGROUND_LOCATION,
  FOREGROUND_LOCATION,
  GEOFENCE_DWELL,
  GEOFENCE_ENTER,
  GEOFENCE_EXIT,
  MANUAL_LOCATION,
  MOCK_LOCATION,
  UNKNOWN,
}
