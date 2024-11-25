// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageCountImpl _$$MessageCountImplFromJson(Map<String, dynamic> json) =>
    _$MessageCountImpl(
      count: (json['count'] as num).toInt(),
      lastMessageId: (json['last_message_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessageCountImplToJson(_$MessageCountImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'last_message_id': instance.lastMessageId,
    };
