import 'package:flutter/material.dart';
import 'package:ql_dvhc/data/app_service.dart';
import 'package:ql_dvhc/models/district_model.dart';
import 'package:ql_dvhc/models/province_model.dart';
import 'package:ql_dvhc/models/ward_model.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel._internal();
  static final _instance = HomeViewmodel._internal();
  factory HomeViewmodel() {
    return _instance;
  }

  void notify() {
    notifyListeners();
  }

  final _service = AppService();
  List<ProvinceModel> provinces = [];
  List<DistrictModel> districts = [];
  List<WardModel> wards = [];

  Future<void> getUnits() async {
    final data = await _service.getUnits();
    data.forEach((key, value) {
      if (key.contains('province_')) {
        provinces.add(ProvinceModel.fromJson(value));
      } else if (key.contains('district_')) {
        districts.add(DistrictModel.fromJson(value));
      } else {
        wards.add(WardModel.fromJson(value));
      }
    });
  }

  Future<ProvinceModel> addProvince({
    String? id,
    required int code,
    required String name,
    required String level,
  }) async {
    final province = ProvinceModel(
      id: id ?? 'province_$code',
      code: code,
      name: name,
      level: level,
    );

    await _service.addProvince(province);
    if (id != null) {
      provinces.removeWhere((item) => item.id == id);
    }
    provinces.insert(0, province);
    notifyListeners();
    return province;
  }

  Future<DistrictModel> addDistrict({
    required int pCode,
    required int code,
    required String name,
    required String level,
    String? id,
  }) async {
    final district = DistrictModel(
      id: id ?? 'district_$code',
      code: code,
      pCode: pCode,
      name: name,
      level: level,
    );

    _service.addDistrict(district);
    if (id != null) {
      districts.removeWhere((item) => item.id == id);
    }
    districts.insert(0, district);
    notifyListeners();
    return district;
  }

  Future<WardModel> addWard({
    required int dCode,
    required int code,
    required String name,
    required String level,
    String? id,
  }) async {
    final ward = WardModel(
      id: id ?? 'ward_$code',
      code: code,
      dCode: dCode,
      name: name,
      level: level,
    );

    _service.addWard(ward);

    if (id != null) {
      wards.removeWhere((item) => item.id == id);
    }

    wards.insert(0, ward);
    notifyListeners();
    return ward;
  }

  Future<void> deleteUnit(int unitType, dynamic unit) async {
    if (unitType == 1) {
      provinces.removeWhere((item) => item.id == unit.id);
    } else if (unitType == 2) {
      districts.removeWhere((item) => item.id == unit.id);
    } else {
      wards.removeWhere((item) => item.id == unit.id);
    }
    _service.deleteUnit(unit.id);
    notifyListeners();
  }
}
