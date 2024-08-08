// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProvinceModel {
  final String id;
  final int code;
  final String name;
  final String level;

  ProvinceModel({
    required this.id,
    required this.code,
    required this.name,
    required this.level,
  });

  ProvinceModel copyWith({
    String? id,
    int? code,
    String? name,
    String? level,
  }) {
    return ProvinceModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'level': level,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: map['id'] as String,
      code: map['code'] as int,
      name: map['name'] as String,
      level: map['level'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) =>
      ProvinceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProvinceModel(id: $id, code: $code, name: $name, level: $level)';
  }

  @override
  bool operator ==(covariant ProvinceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.level == level;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ name.hashCode ^ level.hashCode;
  }
}
