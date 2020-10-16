// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarReceiver _$RadarReceiverFromJson(Map<String, dynamic> json) {
  return RadarReceiver(
    _$enumDecodeNullable(_$EventTypeEnumMap, json['eventType']),
    (json['events'] as List)
        ?.map((e) =>
            e == null ? null : RadarEvent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : RadarUser.fromJson(json['user'] as Map<String, dynamic>),
    json['stopped'] as bool,
    _$enumDecodeNullable(_$RadarLocationSourceEnumMap, json['source']),
    _$enumDecodeNullable(_$RadarStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$RadarReceiverToJson(RadarReceiver instance) =>
    <String, dynamic>{
      'eventType': _$EventTypeEnumMap[instance.eventType],
      'events': instance.events,
      'location': instance.location,
      'user': instance.user,
      'stopped': instance.stopped,
      'source': _$RadarLocationSourceEnumMap[instance.source],
      'status': _$RadarStatusEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EventTypeEnumMap = {
  EventType.EVENTS_RECEIVED: 'EVENTS_RECEIVED',
  EventType.CLIENT_LOCATION_UPDATED: 'CLIENT_LOCATION_UPDATED',
  EventType.LOCATION_UPDATED: 'LOCATION_UPDATED',
  EventType.ERROR: 'ERROR',
};

const _$RadarLocationSourceEnumMap = {
  RadarLocationSource.BACKGROUND_LOCATION: 'BACKGROUND_LOCATION',
  RadarLocationSource.FOREGROUND_LOCATION: 'FOREGROUND_LOCATION',
  RadarLocationSource.GEOFENCE_DWELL: 'GEOFENCE_DWELL',
  RadarLocationSource.GEOFENCE_ENTER: 'GEOFENCE_ENTER',
  RadarLocationSource.GEOFENCE_EXIT: 'GEOFENCE_EXIT',
  RadarLocationSource.MANUAL_LOCATION: 'MANUAL_LOCATION',
  RadarLocationSource.MOCK_LOCATION: 'MOCK_LOCATION',
  RadarLocationSource.UNKNOWN: 'UNKNOWN',
};

const _$RadarStatusEnumMap = {
  RadarStatus.ERROR_BAD_REQUEST: 'ERROR_BAD_REQUEST',
  RadarStatus.ERROR_FORBIDDEN: 'ERROR_FORBIDDEN',
  RadarStatus.ERROR_LOCATION: 'ERROR_LOCATION',
  RadarStatus.ERROR_NETWORK: 'ERROR_NETWORK',
  RadarStatus.ERROR_NOT_FOUND: 'ERROR_NOT_FOUND',
  RadarStatus.ERROR_PAYMENT_REQUIRED: 'ERROR_PAYMENT_REQUIRED',
  RadarStatus.ERROR_PERMISSIONS: 'ERROR_PERMISSIONS',
  RadarStatus.ERROR_PUBLISHABLE_KEY: 'ERROR_PUBLISHABLE_KEY',
  RadarStatus.ERROR_RATE_LIMIT: 'ERROR_RATE_LIMIT',
  RadarStatus.ERROR_SERVER: 'ERROR_SERVER',
  RadarStatus.ERROR_UNAUTHORIZED: 'ERROR_UNAUTHORIZED',
  RadarStatus.ERROR_UNKNOWN: 'ERROR_UNKNOWN',
  RadarStatus.SUCCESS: 'SUCCESS',
};

RadarUser _$RadarUserFromJson(Map<String, dynamic> json) {
  return RadarUser(
    json['id'] as String,
    json['userId'] as String,
    json['deviceId'] as String,
    json['description'] as String,
    json['metadata'] as Map<String, dynamic>,
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    (json['geofences'] as List)
        ?.map((e) => e == null
            ? null
            : RadarGeofence.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['place'] == null
        ? null
        : RadarPlace.fromJson(json['place'] as Map<String, dynamic>),
    json['stopped'] as bool,
    json['foreground'] as bool,
    json['country'] == null
        ? null
        : RadarRegion.fromJson(json['country'] as Map<String, dynamic>),
    json['state'] == null
        ? null
        : RadarRegion.fromJson(json['state'] as Map<String, dynamic>),
    json['dma'] == null
        ? null
        : RadarRegion.fromJson(json['dma'] as Map<String, dynamic>),
    json['postalCode'] == null
        ? null
        : RadarRegion.fromJson(json['postalCode'] as Map<String, dynamic>),
    (json['nearbyPlaceChains'] as List)
        ?.map((e) =>
            e == null ? null : RadarChain.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['segments'] as List)
        ?.map((e) =>
            e == null ? null : RadarSegment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['topChains'] as List)
        ?.map((e) =>
            e == null ? null : RadarChain.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    _$enumDecodeNullable(_$RadarLocationSourceEnumMap, json['source']),
    json['proxy'] as bool,
  );
}

Map<String, dynamic> _$RadarUserToJson(RadarUser instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'deviceId': instance.deviceId,
      'description': instance.description,
      'metadata': instance.metadata,
      'location': instance.location,
      'geofences': instance.geofences,
      'place': instance.place,
      'stopped': instance.stopped,
      'foreground': instance.foreground,
      'country': instance.country,
      'state': instance.state,
      'dma': instance.dma,
      'postalCode': instance.postalCode,
      'nearbyPlaceChains': instance.nearbyPlaceChains,
      'segments': instance.segments,
      'topChains': instance.topChains,
      'source': _$RadarLocationSourceEnumMap[instance.source],
      'proxy': instance.proxy,
    };

RadarEvent _$RadarEventFromJson(Map<String, dynamic> json) {
  return RadarEvent(
    json['id'] as String,
    (json['createdAt'] as num)?.toDouble(),
    (json['actualCreatedAt'] as num)?.toDouble(),
    json['live'] as bool,
    _$enumDecodeNullable(_$RadarEventTypeEnumMap, json['type']),
    json['geofence'] == null
        ? null
        : RadarGeofence.fromJson(json['geofence'] as Map<String, dynamic>),
    json['place'] == null
        ? null
        : RadarPlace.fromJson(json['place'] as Map<String, dynamic>),
    json['region'] == null
        ? null
        : RadarRegion.fromJson(json['region'] as Map<String, dynamic>),
    (json['alternatePlaces'] as List)
        ?.map((e) =>
            e == null ? null : RadarPlace.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['verifiedPlace'] == null
        ? null
        : RadarPlace.fromJson(json['verifiedPlace'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$RadarEventVerificationEnumMap, json['verification']),
    _$enumDecodeNullable(_$RadarEventConfidenceEnumMap, json['confidence']),
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RadarEventToJson(RadarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'actualCreatedAt': instance.actualCreatedAt,
      'live': instance.live,
      'type': _$RadarEventTypeEnumMap[instance.type],
      'geofence': instance.geofence,
      'place': instance.place,
      'region': instance.region,
      'alternatePlaces': instance.alternatePlaces,
      'verifiedPlace': instance.verifiedPlace,
      'verification': _$RadarEventVerificationEnumMap[instance.verification],
      'confidence': _$RadarEventConfidenceEnumMap[instance.confidence],
      'location': instance.location,
    };

const _$RadarEventTypeEnumMap = {
  RadarEventType.UNKNOWN: 'UNKNOWN',
  RadarEventType.USER_ENTERED_GEOFENCE: 'USER_ENTERED_GEOFENCE',
  RadarEventType.USER_ENTERED_HOME: 'USER_ENTERED_HOME',
  RadarEventType.USER_ENTERED_OFFICE: 'USER_ENTERED_OFFICE',
  RadarEventType.USER_ENTERED_PLACE: 'USER_ENTERED_PLACE',
  RadarEventType.USER_ENTERED_REGION_COUNTRY: 'USER_ENTERED_REGION_COUNTRY',
  RadarEventType.USER_ENTERED_REGION_DMA: 'USER_ENTERED_REGION_DMA',
  RadarEventType.USER_ENTERED_REGION_STATE: 'USER_ENTERED_REGION_STATE',
  RadarEventType.USER_EXITED_GEOFENCE: 'USER_EXITED_GEOFENCE',
  RadarEventType.USER_EXITED_HOME: 'USER_EXITED_HOME',
  RadarEventType.USER_EXITED_OFFICE: 'USER_EXITED_OFFICE',
  RadarEventType.USER_EXITED_PLACE: 'USER_EXITED_PLACE',
  RadarEventType.USER_EXITED_REGION_COUNTRY: 'USER_EXITED_REGION_COUNTRY',
  RadarEventType.USER_EXITED_REGION_DMA: 'USER_EXITED_REGION_DMA',
  RadarEventType.USER_EXITED_REGION_STATE: 'USER_EXITED_REGION_STATE',
  RadarEventType.USER_NEARBY_PLACE_CHAIN: 'USER_NEARBY_PLACE_CHAIN',
  RadarEventType.USER_STARTED_COMMUTING: 'USER_STARTED_COMMUTING',
  RadarEventType.USER_STARTED_TRAVELING: 'USER_STARTED_TRAVELING',
  RadarEventType.USER_STOPPED_COMMUTING: 'USER_STOPPED_COMMUTING',
  RadarEventType.USER_STOPPED_TRAVELING: 'USER_STOPPED_TRAVELING',
};

const _$RadarEventVerificationEnumMap = {
  RadarEventVerification.ACCEPT: 'ACCEPT',
  RadarEventVerification.REJECT: 'REJECT',
  RadarEventVerification.UNVERIFY: 'UNVERIFY',
};

const _$RadarEventConfidenceEnumMap = {
  RadarEventConfidence.HIGH: 'HIGH',
  RadarEventConfidence.LOW: 'LOW',
  RadarEventConfidence.MEDIUM: 'MEDIUM',
  RadarEventConfidence.NONE: 'NONE',
};

RadarSegment _$RadarSegmentFromJson(Map<String, dynamic> json) {
  return RadarSegment(
    json['description'] as String,
    json['externalId'] as String,
  );
}

Map<String, dynamic> _$RadarSegmentToJson(RadarSegment instance) =>
    <String, dynamic>{
      'description': instance.description,
      'externalId': instance.externalId,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    (json['speed'] as num)?.toDouble(),
    (json['accuracy'] as num)?.toDouble(),
    (json['altitude'] as num)?.toDouble(),
    (json['time'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed': instance.speed,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'time': instance.time,
    };

RadarRegion _$RadarRegionFromJson(Map<String, dynamic> json) {
  return RadarRegion(
    json['id'] as String,
    json['name'] as String,
    json['code'] as String,
    json['type'] as String,
    json['flag'] as String,
  );
}

Map<String, dynamic> _$RadarRegionToJson(RadarRegion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'flag': instance.flag,
    };

RadarPlace _$RadarPlaceFromJson(Map<String, dynamic> json) {
  return RadarPlace(
    json['id'] as String,
    json['name'] as String,
    (json['categories'] as List)?.map((e) => e as String)?.toList(),
    json['chain'] == null
        ? null
        : RadarChain.fromJson(json['chain'] as Map<String, dynamic>),
    json['location'] == null
        ? null
        : RadarCoordinate.fromJson(json['location'] as Map<String, dynamic>),
    json['group'] as String,
    json['metadata'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RadarPlaceToJson(RadarPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categories': instance.categories,
      'chain': instance.chain,
      'location': instance.location,
      'group': instance.group,
      'metadata': instance.metadata,
    };

RadarChain _$RadarChainFromJson(Map<String, dynamic> json) {
  return RadarChain(
    json['slug'] as String,
    json['name'] as String,
    json['ecternalId'] as String,
    json['metadata'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RadarChainToJson(RadarChain instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'ecternalId': instance.ecternalId,
      'metadata': instance.metadata,
    };

RadarGeofence _$RadarGeofenceFromJson(Map<String, dynamic> json) {
  return RadarGeofence(
      json['id'] as String,
      json['description'] as String,
      json['tag'] as String,
      json['externalId'] as String,
      json['metadata'] as Map<String, dynamic>,
      json['geometry'] == null
          ? null
          : json['geometry'].containsKey("center") != null
              ? RadarCircleGeometry.fromJson(
                  json['geometry'] as Map<String, dynamic>)
              : RadarPolygonGeometry.fromJson(
                  json['geometry'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RadarGeofenceToJson(RadarGeofence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'tag': instance.tag,
      'externalId': instance.externalId,
      'metadata': instance.metadata,
      'geometry': instance.geometry,
    };

RadarCircleGeometry _$RadarCircleGeometryFromJson(Map<String, dynamic> json) {
  return RadarCircleGeometry(
    json['center'] == null
        ? null
        : RadarCoordinate.fromJson(json['center'] as Map<String, dynamic>),
    (json['radius'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RadarCircleGeometryToJson(
        RadarCircleGeometry instance) =>
    <String, dynamic>{
      'center': instance.center,
      'radius': instance.radius,
    };

RadarPolygonGeometry _$RadarPolygonGeometryFromJson(Map<String, dynamic> json) {
  return RadarPolygonGeometry(
    (json['coordinates'] as List)
        ?.map((e) => e == null
            ? null
            : RadarCoordinate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RadarPolygonGeometryToJson(
        RadarPolygonGeometry instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
    };

RadarCoordinate _$RadarCoordinateFromJson(Map<String, dynamic> json) {
  return RadarCoordinate(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RadarCoordinateToJson(RadarCoordinate instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
