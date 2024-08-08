import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ql_dvhc/models/district_model.dart';
import 'package:ql_dvhc/models/province_model.dart';
import 'package:ql_dvhc/models/ward_model.dart';

// import '../models/province_model.dart';

class AppService {
  AppService._internal();
  static final _instance = AppService._internal();
  factory AppService() {
    return _instance;
  }

  /// Storage
  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> getUnits() async {
    // await _storage.deleteAll();
    return await _storage.readAll();
  }

  Future<void> addProvince(ProvinceModel province) async {
    await _storage.write(
      key: province.id,
      value: province.toJson(),
    );
  }

  Future<void> addDistrict(DistrictModel district) async {
    await _storage.write(
      key: district.id,
      value: district.toJson(),
    );
  }

  Future<void> addWard(WardModel ward) async {
    await _storage.write(
      key: ward.id,
      value: ward.toJson(),
    );
  }

  Future<void> deleteUnit(String unitId) async {
    await _storage.delete(key: unitId);
  }
}
