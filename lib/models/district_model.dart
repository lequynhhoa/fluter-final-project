// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DistrictModel {
  final String id;
  final int code;
  final String name;
  final String level;
  final int pCode;
  DistrictModel({
    required this.id,
    required this.code,
    required this.name,
    required this.level,
    required this.pCode,
  });

  DistrictModel copyWith({
    String? id,
    int? code,
    String? name,
    String? level,
    int? pCode,
  }) {
    return DistrictModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      level: level ?? this.level,
      pCode: pCode ?? this.pCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name': name,
      'level': level,
      'pCode': pCode,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      id: map['id'] as String,
      code: map['code'] as int,
      name: map['name'] as String,
      level: map['level'] as String,
      pCode: map['pCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictModel.fromJson(String source) =>
      DistrictModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DistrictModel(id: $id, code: $code, name: $name, level: $level, pCode: $pCode)';
  }

  @override
  bool operator ==(covariant DistrictModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.level == level &&
        other.pCode == pCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        level.hashCode ^
        pCode.hashCode;
  }
}
