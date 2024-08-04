// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderDtoImpl _$$OrderDtoImplFromJson(Map<String, dynamic> json) =>
    _$OrderDtoImpl(
      date: json['date'] as int,
      pickupOption: $enumDecode(_$PickupOptionEnumMap, json['pickupOption']),
      paymentMethod: json['paymentMethod'] as String,
      address: json['addressModel'] == null
          ? null
          : AddressDto.fromJson(json['addressModel'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String,
      userPhone: json['userPhone'] as String,
      userNote: json['userNote'] as String,
      employeeCancelNote: json['employeeCancelNote'] as String?,
      deliveryStatus:
          $enumDecode(_$DeliveryStatusEnumMap, json['deliveryStatus']),
      deliveryId: json['deliveryId'] as String?,
      deliveryGeoPoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['deliveryGeoPoint'], const GeoPointConverter().fromJson),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$OrderDtoImplToJson(_$OrderDtoImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'pickupOption': _$PickupOptionEnumMap[instance.pickupOption]!,
      'paymentMethod': instance.paymentMethod,
      'addressModel': instance.address?.toJson(),
      'userId': instance.userId,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'userPhone': instance.userPhone,
      'userNote': instance.userNote,
      'employeeCancelNote': instance.employeeCancelNote,
      'deliveryStatus': _$DeliveryStatusEnumMap[instance.deliveryStatus]!,
      'deliveryId': instance.deliveryId,
      'deliveryGeoPoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.deliveryGeoPoint, const GeoPointConverter().toJson),
    };

const _$PickupOptionEnumMap = {
  PickupOption.delivery: 'delivery',
  PickupOption.pickUp: 'pickUp',
  PickupOption.diningRoom: 'diningRoom',
};

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.pending: 'pending',
  DeliveryStatus.upcoming: 'upcoming',
  DeliveryStatus.onTheWay: 'onTheWay',
  DeliveryStatus.delivered: 'delivered',
  DeliveryStatus.canceled: 'canceled',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$AddressDtoImpl _$$AddressDtoImplFromJson(Map<String, dynamic> json) =>
    _$AddressDtoImpl(
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      mobile: json['mobile'] as String,
      geoPoint: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['geoPoint'], const GeoPointConverter().fromJson),
    );

Map<String, dynamic> _$$AddressDtoImplToJson(_$AddressDtoImpl instance) =>
    <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'mobile': instance.mobile,
      'geoPoint': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.geoPoint, const GeoPointConverter().toJson),
    };
