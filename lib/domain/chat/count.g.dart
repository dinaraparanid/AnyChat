// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageCountImpl _$$MessageCountImplFromJson(Map<String, dynamic> json) =>
    _$MessageCountImpl(
      count: (json['count'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
    );

Map<String, dynamic> _$$MessageCountImplToJson(_$MessageCountImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'last_page': instance.lastPage,
    };
