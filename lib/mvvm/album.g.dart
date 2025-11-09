// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Album _$AlbumFromJson(Map<String, dynamic> json) => _Album(
  userId: (json['userId'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
);

Map<String, dynamic> _$AlbumToJson(_Album instance) => <String, dynamic>{
  'userId': instance.userId,
  'id': instance.id,
  'title': instance.title,
};
