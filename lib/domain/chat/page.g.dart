// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessagePageImpl _$$MessagePageImplFromJson(Map<String, dynamic> json) =>
    _$MessagePageImpl(
      page: (json['page'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: (json['next'] as num?)?.toInt(),
      previous: (json['previous'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessagePageImplToJson(_$MessagePageImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
      'messages': instance.messages,
      'next': instance.next,
      'previous': instance.previous,
    };
