// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Album implements DiagnosticableTreeMixin {

 int? get userId; int? get id; String? get title;
/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumCopyWith<Album> get copyWith => _$AlbumCopyWithImpl<Album>(this as Album, _$identity);

  /// Serializes this Album to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Album'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Album&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,id,title);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Album(userId: $userId, id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class $AlbumCopyWith<$Res>  {
  factory $AlbumCopyWith(Album value, $Res Function(Album) _then) = _$AlbumCopyWithImpl;
@useResult
$Res call({
 int? userId, int? id, String? title
});




}
/// @nodoc
class _$AlbumCopyWithImpl<$Res>
    implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._self, this._then);

  final Album _self;
  final $Res Function(Album) _then;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? id = freezed,Object? title = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Album].
extension AlbumPatterns on Album {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Album value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Album() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Album value)  $default,){
final _that = this;
switch (_that) {
case _Album():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Album value)?  $default,){
final _that = this;
switch (_that) {
case _Album() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? userId,  int? id,  String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Album() when $default != null:
return $default(_that.userId,_that.id,_that.title);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? userId,  int? id,  String? title)  $default,) {final _that = this;
switch (_that) {
case _Album():
return $default(_that.userId,_that.id,_that.title);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? userId,  int? id,  String? title)?  $default,) {final _that = this;
switch (_that) {
case _Album() when $default != null:
return $default(_that.userId,_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Album with DiagnosticableTreeMixin implements Album {
  const _Album({this.userId, this.id, this.title});
  factory _Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

@override final  int? userId;
@override final  int? id;
@override final  String? title;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumCopyWith<_Album> get copyWith => __$AlbumCopyWithImpl<_Album>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlbumToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Album'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Album&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,id,title);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Album(userId: $userId, id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$AlbumCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$AlbumCopyWith(_Album value, $Res Function(_Album) _then) = __$AlbumCopyWithImpl;
@override @useResult
$Res call({
 int? userId, int? id, String? title
});




}
/// @nodoc
class __$AlbumCopyWithImpl<$Res>
    implements _$AlbumCopyWith<$Res> {
  __$AlbumCopyWithImpl(this._self, this._then);

  final _Album _self;
  final $Res Function(_Album) _then;

/// Create a copy of Album
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? id = freezed,Object? title = freezed,}) {
  return _then(_Album(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
