// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      firstForDate: json['first_for_date'] as bool?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'timestamp': instance.timestamp,
      'first_for_date': instance.firstForDate,
    };
