// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WardModel {
  final String id;
  final int code;
  final String name;
  final String level;
  final int dCode;

  WardModel({
    required this.id,
    required this.code,
    required this.name,
    required this.level,
    required this.dCode,
  });

  WardModel copyWith({
    String? id,
    int? code,
    String? name,
    String? level,
    int? dCode,
  }) {
    return WardModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      level: level ?? this.level,
      dCode: dCode ?? this.dCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'level': level,
      'dCode': dCode,
    };
  }

  factory WardModel.fromMap(Map<String, dynamic> map) {
    return WardModel(
      id: map['id'] as String,
      code: map['code'] as int,
      name: map['name'] as String,
      level: map['level'] as String,
      dCode: map['dCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WardModel.fromJson(String source) =>
      WardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WardModel(id: $id, code: $code, name: $name, level: $level, dCode: $dCode)';
  }

  @override
  bool operator ==(covariant WardModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.level == level &&
        other.dCode == dCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        level.hashCode ^
        dCode.hashCode;
  }
}
